package com.classare.util;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class DBConnection {
        private static HikariDataSource dataSource;

        static {
                HikariConfig config = new HikariConfig();
                String dbUrl = System.getenv("DB_URL") != null ? System.getenv("DB_URL") : "jdbc:mysql://localhost:3306/classare?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
                String dbUser = System.getenv("DB_USER") != null ? System.getenv("DB_USER") : "root";
                String dbPassword = System.getenv("DB_PASSWORD") != null ? System.getenv("DB_PASSWORD") : "1111";

                config.setJdbcUrl(dbUrl);
                config.setUsername(dbUser);
                config.setPassword(dbPassword);
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