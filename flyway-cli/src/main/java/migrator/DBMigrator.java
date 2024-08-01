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
        try {
            dbConnectionChecker.checkDBConnection();
        } catch (SQLException e) {
            Log.error( "Error obtaining database connection. Are the db url, username and password correct? Exiting.: " + e.toString());
            System.exit(-1);
            return -1;
        }

        service.checkMigration();
        System.exit(0);
        return 0;
    }
}