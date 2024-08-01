package migrator;

import io.quarkus.runtime.QuarkusApplication;
import io.quarkus.runtime.annotations.QuarkusMain;
import jakarta.inject.Inject;
import io.quarkus.logging.Log; 

@QuarkusMain
public class DBMigrator implements QuarkusApplication {

    @Inject
    MigrationService service;

    @Override
    public int run(String... args) {
        try {
            service.checkMigration();
            System.exit(0);
            return 0;
        } catch(Exception e) {
            Log.error( "Error performing database migration: " + e.toString());
        }
        System.exit(-1);
        return -1;
    }
}