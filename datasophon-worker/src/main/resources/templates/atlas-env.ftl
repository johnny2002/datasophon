#!/bin/bash
# 参考：doris_fe.ftl 的环境变量配置

# Atlas安装目录
export ATLAS_HOME=${r"${INSTALL_PATH}"}/apache-atlas-4.0.0
export ATLAS_CONF=${r"${ATLAS_HOME}"}/conf
export ATLAS_LOG=${r"${ATLAS_HOME}"}/logs

# Java配置
export JAVA_HOME=${r"${JAVA_HOME}"}
export ATLAS_OPTS="-Xmx4096m -Xms4096m -Dlog4j.configuration=atlas-log4j.xml -Djava.library.path=${r"${HADOOP_HOME}"}/lib/native"

# 依赖组件配置目录
export HBASE_CONF_DIR=${r"${HBASE_HOME}"}/conf
export HADOOP_CONF_DIR=${r"${HADOOP_HOME}"}/etc/hadoop
export KAFKA_HOME=${r"${KAFKA_HOME}"}

# 自定义JVM参数
<#if atlas_jvm_opts??>${atlas_jvm_opts}</#if>