package migrator;

import io.quarkus.runtime.QuarkusApplication;
import io.quarkus.runtime.annotations.QuarkusMain;
import jakarta.inject.Inject;
import io.quarkus.logging.Log;

import java.sql.SQLException;

import org.eclipse.microprofile.config.inject.ConfigProperty;

@QuarkusMain
public class DBMigrator implements QuarkusApplication {

    @Inject
    MigrationService service;

    @Inject
    DBConnectionChecker dbConnectionChecker;

    @ConfigProperty(name = "migrate.db.dataindex")
    Boolean migrateDataIndex;

    @ConfigProperty(name = "migrate.db.jobsservice")
    Boolean migrateJobsService;

    @Override
    public int run(String... args) {
        if (migrateDataIndex) {
            try {
                dbConnectionChecker.checkDataIndexDBConnection();
            } catch (SQLException e) {
                Log.error( "Error obtaining data index database connection. Cannot proceed, exiting.");
                System.exit(-1);
                return -1;
            }
            service.migrateDataIndex();
        }

        if (migrateJobsService) {
            try {
                dbConnectionChecker.checkJobsServiceDBConnection();
            } catch (SQLException e) {
                Log.error( "Error obtaining jobs service database connection. Cannot proceed, exiting.");
                System.exit(-2);
                return -2;
            }
            service.migrateJobsService();
        }

        System.exit(0);
        return 0;
    }
}