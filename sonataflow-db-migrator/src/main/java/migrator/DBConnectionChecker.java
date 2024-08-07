package migrator;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.eclipse.microprofile.config.inject.ConfigProperty;

import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class DBConnectionChecker {
    @ConfigProperty(name = "quarkus.datasource.dataindex.jdbc.url")
    String dataIndexDBURL;

    @ConfigProperty(name = "quarkus.datasource.dataindex.username")
    String dataIndexDBUserName;

    @ConfigProperty(name = "quarkus.datasource.dataindex.password")
    String dataIndexDBPassword;

    @ConfigProperty(name = "quarkus.datasource.jobsservice.jdbc.url")
    String jobsServiceDBURL;

    @ConfigProperty(name = "quarkus.datasource.jobsservice.username")
    String jobsServiceDBUserName;

    @ConfigProperty(name = "quarkus.datasource.jobsservice.password")
    String jobsServiceDBPassword;

    @SuppressWarnings("unused")
    public void checkDataIndexDBConnection() throws SQLException {
        Connection db = DriverManager.getConnection(dataIndexDBURL, dataIndexDBUserName, dataIndexDBPassword);
    }

    @SuppressWarnings("unused")
    public void checkJobsServiceDBConnection() throws SQLException {
        Connection db = DriverManager.getConnection(jobsServiceDBURL, jobsServiceDBUserName, jobsServiceDBPassword);
    }
}
