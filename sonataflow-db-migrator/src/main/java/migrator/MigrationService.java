package migrator;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.flywaydb.core.Flyway;

@ApplicationScoped
public class MigrationService {
    @Inject
    Flyway flyway;

    public void checkMigration() {
        System.out.println("Checking migration...");
        flyway.clean();
        flyway.migrate();
        System.out.println(flyway.info().current().getVersion().toString());
    }
}