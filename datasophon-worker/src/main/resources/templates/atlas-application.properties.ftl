
# 认证配置

atlas.authentication.method.ldap=false
atlas.authentication.method.kerberos=false
atlas.authentication.method.file=true
atlas.authentication.file.filename=${atlas_home}/conf/users-credentials.properties

atlas.authorizer.impl=simple
atlas.authorizer.simple.authz.policy.file=atlas-simple-authz-policy.json
atlas.audit.hbase.tablename=apache_atlas_entity_audit
atlas.audit.hbase.zookeeper.quorum=${zkQuorum}
atlas.audit.zookeeper.session.timeout.ms=1000
atlas.EntityAuditRepository.impl=org.apache.atlas.repository.audit.HBaseBasedAuditRepository

atlas.graph.index.search.backend=elasticsearch
atlas.graph.index.search.elasticsearch.client-only=true
atlas.graph.index.search.hostname=10.16.10.96:9200,10.16.10.97:9200,10.16.10.98:9200
atlas.graph.storage.backend=hbase2
atlas.graph.storage.hbase.ext.zookeeper.znode.parent=/hbase
atlas.graph.storage.hbase.regions-per-server=1
atlas.graph.storage.hbase.table=apache_atlas_janus
atlas.graph.storage.hostname=${atlas_graph_storage_hostname}
atlas.search.gremlin.enable=false

atlas.kafka.auto.commit.interval.ms=1000
atlas.kafka.auto.offset.reset=earliest
atlas.kafka.bootstrap.servers=${atlas_kafka_bootstrap_servers}
atlas.kafka.zookeeper.connect=${zkQuorum}
atlas.kafka.zookeeper.connection.timeout.ms=200
atlas.kafka.data=${atlas_home}/data/kafka
atlas.kafka.enable.auto.commit=false
atlas.kafka.hook.group.id=atlas
atlas.kafka.offsets.topic.replication.factor=1
atlas.kafka.poll.timeout.ms=1000
atlas.kafka.session.timeout.ms=30000
atlas.kafka.zookeeper.session.timeout.ms=400
atlas.kafka.zookeeper.sync.time.ms=20

atlas.metric.query.cache.ttlInSecs=900

atlas.notification.consumer.retry.interval=500
atlas.notification.create.topics=true
atlas.notification.embedded=false
atlas.notification.hook.retry.interval=1000
atlas.notification.log.failed.messages=true
atlas.notification.replicas=1
atlas.notification.topics=ATLAS_HOOK,ATLAS_ENTITIES

# ==================== 高可用配置 ====================
# 集群配置（如果启用高可用）
atlas.server.ha.enabled=false
# atlas.server.ha.zookeeper.connect=${zkQuorum}
# atlas.server.ha.zookeeper.znode.parent=/apache_atlas
# atlas.server.id=server1
# atlas.server.address=host1.example.com:21000

atlas.enableTLS=false
atlas.rest.address=http://${host}:${atlas_server_port}
atlas.server.port=${atlas_server_port}
atlas.ui.default.version=v1
atlas.rest-csrf.browser-useragents-regex=^Mozilla.*,^Opera.*,^Chrome.*
atlas.rest-csrf.custom-header=X-XSRF-HEADER
atlas.rest-csrf.enabled=true
atlas.rest-csrf.methods-to-ignore=GET,OPTIONS,HEAD,TRACE