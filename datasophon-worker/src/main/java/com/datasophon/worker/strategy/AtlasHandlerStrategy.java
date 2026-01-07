package com.datasophon.worker.strategy;

import com.datasophon.common.Constants;
import com.datasophon.common.cache.CacheUtils;
import com.datasophon.common.command.ServiceRoleOperateCommand;
import com.datasophon.common.enums.CommandType;
import com.datasophon.common.utils.ExecResult;
import com.datasophon.common.utils.ShellUtils;
import com.datasophon.worker.handler.ServiceHandler;
import com.datasophon.worker.utils.KerberosUtils;

import cn.hutool.core.io.FileUtil;

import java.util.ArrayList;

public class AtlasHandlerStrategy extends AbstractHandlerStrategy implements ServiceRoleStrategy {

    public AtlasHandlerStrategy(String serviceName, String serviceRoleName) {
        super(serviceName, serviceRoleName);
    }

    @Override
    public ExecResult handler(ServiceRoleOperateCommand command) {
        ExecResult result = new ExecResult();
        ServiceHandler serviceHandler = new ServiceHandler(command.getServiceName(), command.getServiceRoleName());

        String workPath = Constants.INSTALL_PATH + Constants.SLASH + command.getDecompressPackageName();

        // INSTALL阶段特殊处理
        if (command.getCommandType().equals(CommandType.INSTALL_SERVICE)) {
            logger.info("开始安装Atlas服务");

            // 1. 如果需要，执行Atlas特有的安装步骤
            // Atlas通常只需要解压，但可以添加一些初始化

            // 2. Kerberos支持
            if (command.getEnableKerberos()) {
                logger.info("配置Atlas Kerberos支持");
                KerberosUtils.createKeytabDir();
                String hostname = CacheUtils.getString(Constants.HOSTNAME);
                if (!FileUtil.exist("/etc/security/keytab/atlas.keytab")) {
                    KerberosUtils.downloadKeytabFromMaster("atlas/" + hostname, "atlas.keytab");
                }
            }

            // 3. 初始化HBase表（如果需要）
            logger.info("检查是否需要初始化HBase表");
            ArrayList<String> initCommands = new ArrayList<>();
            initCommands.add(workPath + "/bin/atlas_start.py");
            initCommands.add("-setup");
            ShellUtils.execWithStatus(workPath, initCommands, 600L, logger);

            logger.info("Atlas服务安装完成");
        }

        // 启动服务（使用serviceHandler的标准启动逻辑）
        result = serviceHandler.start(
                command.getStartRunner(),
                command.getStatusRunner(),
                command.getDecompressPackageName(),
                command.getRunAs()
        );

        return result;
    }
}