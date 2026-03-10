package com.classare.util;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class DBConnection {
        private static HikariDataSource dataSource;

        static {
                HikariConfig config = new HikariConfig();
                config.setJdbcUrl("jdbc:mysql://localhost:3306/classare?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true");
//                config.setJdbcUrl("jdbc:mysql://localhost:3306/educore?useSSL=false&serverTimezone=UTC");
                config.setUsername("root");
                config.setPassword("1111");
                config.setDriverClassName("com.mysql.cj.jdbc.Driver");
                try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                } catch (ClassNotFoundException e) {
                        e.printStackTrace();
                }

                config.setMaximumPoolSize(10);
                config.setMinimumIdle(5);
                config.setIdleTimeout(300000);
                config.addDataSourceProperty("cachePrepStmts", "true");
                config.addDataSourceProperty("prepStmtCacheSize", "250");


                dataSource = new HikariDataSource(config);
        }

        public static Connection getConnection() throws SQLException {
                return dataSource.getConnection();
        }

        private DBConnection() {}
}