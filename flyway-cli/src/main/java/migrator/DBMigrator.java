package migrator;

import io.quarkus.runtime.QuarkusApplication;
import io.quarkus.runtime.annotations.QuarkusMain;
import jakarta.inject.Inject;

@QuarkusMain
public class DBMigrator implements QuarkusApplication {

    @Inject
    MigrationService service;

    @Override
    public int run(String... args) throws Exception {
        service.checkMigration();
        System.exit(0);
        return 0;
    }
}