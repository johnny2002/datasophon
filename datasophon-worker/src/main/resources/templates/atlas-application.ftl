# 参考：ranger-hdfs.ftl 和 clickhouse-server-config.ftl 的模板语法
# Atlas主配置文件

# 存储配置
atlas.graph.storage.backend=hbase2
atlas.graph.storage.hostname=${atlas.graph.storage.hostname}
atlas.graph.storage.hbase.table=atlas

# Kafka配置
atlas.notification.embedded=false
atlas.kafka.bootstrap.servers=${atlas.kafka.bootstrap.servers}
atlas.kafka.zookeeper.connect=${zkQuorum}
atlas.kafka.enable=true

# 服务配置
atlas.rest.address=http://${host}:${atlas.server.port}
atlas.server.port=${atlas.server.port}
atlas.server.http.port=21000
atlas.server.https.port=21443

# 审计配置
atlas.audit.hbase.tablename=apache_atlas_entity_audit

# 认证配置
<#if atlas.authentication.method.ldap.url?? && atlas.authentication.method.ldap.url != "">
    atlas.authentication.method.ldap=true
    atlas.authentication.method.ldap.url=${atlas.authentication.method.ldap.url}
<#else>
    atlas.authentication.method.file=true
    atlas.authentication.file.filename=${atlas_home}/conf/users-credentials.properties
</#if>

# 搜索配置（使用Solr）
atlas.graph.index.search.backend=solr5
atlas.graph.index.search.solr.mode=cloud
atlas.graph.index.search.solr.zookeeper-url=${zkQuorum}