package migrator;

import io.quarkus.runtime.QuarkusApplication;
import io.quarkus.runtime.annotations.QuarkusMain;
import jakarta.inject.Inject;
import io.quarkus.logging.Log;

import java.sql.SQLException;

@QuarkusMain
public class DBMigrator implements QuarkusApplication {

    @Inject
    MigrationService service;

    @Inject
    DBConnectionChecker dbConnectionChecker;

    @Override
    public int run(String... args) {
        boolean dataIndexDBAvailable = true;
        boolean jobsServiceDBAvailable = true;

        try {
            dbConnectionChecker.checkDataIndexDBConnection();
        } catch (SQLException e) {
            dataIndexDBAvailable = false;
        }

        try {
            dbConnectionChecker.checkJobsServiceDBConnection();
        } catch (SQLException e) {
            jobsServiceDBAvailable = false;
        }

        if (dataIndexDBAvailable && jobsServiceDBAvailable) {
            service.checkMigration();
            System.exit(0);
            return 0;
        } else {
            Log.error( "Error obtaining data index or jobs service or both service's database connection. Are they available? Cannot proceed, exiting.");
            System.exit(-1);
            return -1;
        }
    }
}