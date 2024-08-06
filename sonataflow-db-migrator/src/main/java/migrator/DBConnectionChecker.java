package migrator;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.eclipse.microprofile.config.inject.ConfigProperty;

import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class DBConnectionChecker {
    @ConfigProperty(name = "quarkus.datasource.jdbc.url")
    String dbURL;

    @ConfigProperty(name = "quarkus.datasource.username")
    String username;

    @ConfigProperty(name = "quarkus.datasource.password")
    String password;

    @SuppressWarnings("unused")
    public void checkDBConnection() throws SQLException {
        Connection db = DriverManager.getConnection(dbURL, username, password);
    }
}
