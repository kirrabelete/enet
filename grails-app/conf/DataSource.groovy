dataSource {
    pooled = true
    jmxExport = true
    driverClassName = "com.mysql.jdbc.Driver"
    username = "root"
    password = "password"
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
//    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory' // Hibernate 3
    cache.region.factory_class = 'org.hibernate.cache.ehcache.EhCacheRegionFactory' // Hibernate 4
    singleSession = true // configure OSIV singleSession mode
    flush.mode = 'manual' // OSIV session flush mode outside of transactional context
}

// environment specific settings
environments {
    development {
        dataSource {
            dbCreate =  'update' // one of 'Null', 'create', 'create-drop', 'update', 'validate', ''
            url = "jdbc:mysql://localhost:3306/enet?useUnicode=yes&characterEncoding=UTF-8&autoReconnect=true"
            username = 'root'
            password = 'password'
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:h2:mem:testDb;MVCC=TRUE;LOCK_TIMEOUT=10000;DB_CLOSE_ON_EXIT=FALSE"
        }
    }
    production {
        dataSource {
            dbCreate = "update"
            driverClassName = 'com.mysql.jdbc.Driver'
            dialect = org.hibernate.dialect.MySQL5InnoDBDialect
            String host = System.getenv('OPENSHIFT_MYSQL_DB_HOST')
            String port = System.getenv('OPENSHIFT_MYSQL_DB_PORT')
            String dbName = System.getenv('OPENSHIFT_APP_NAME')
            url = "jdbc:mysql://$host:$port/$dbName"
            username = System.getenv('OPENSHIFT_MYSQL_DB_USERNAME')
            password = System.getenv('OPENSHIFT_MYSQL_DB_PASSWORD')

            properties {
               // See http://grails.org/doc/latest/guide/conf.html#dataSource for documentation
               jmxEnabled = true
               initialSize = 5
               maxActive = 50
               minIdle = 5
               maxIdle = 25
               maxWait = 10000
               maxAge = 10 * 60000
               timeBetweenEvictionRunsMillis = 5000
               minEvictableIdleTimeMillis = 60000
               validationQuery = "SELECT 1"
               validationQueryTimeout = 3
               validationInterval = 15000
               testOnBorrow = true
               testWhileIdle = true
               testOnReturn = false
               jdbcInterceptors = "ConnectionState"
               defaultTransactionIsolation = java.sql.Connection.TRANSACTION_READ_COMMITTED
            }
        }
    }
}
