package migrator;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.inject.Named;
import io.quarkus.logging.Log;

import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.flywaydb.core.Flyway;

import io.quarkus.flyway.FlywayDataSource;

@ApplicationScoped
public class MigrationService {
    @Inject
    @FlywayDataSource("dataindex") 
    Flyway flywayDataIndex;

    @Inject
    @FlywayDataSource("jobsservice") 
    Flyway flywayJobsService;

    @ConfigProperty(name = "quarkus.flyway.dataindex.clean-at-start")
    Boolean cleanDataIndex;

    @ConfigProperty(name = "quarkus.flyway.jobsservice.clean-at-start")
    Boolean cleanJobsService;

    public void checkMigration() {
        Log.info("Migrating data index");
        if (cleanDataIndex) {
            Log.info("Cleaned the dataindex");
            flywayDataIndex.clean();
        }
        flywayDataIndex.migrate();
        Log.info(flywayDataIndex.info().current().getVersion().toString());

        Log.info("Migrating jobs service");
        if (cleanJobsService) {
            Log.info("Cleaned the jobsservice");
            flywayJobsService.clean();
        }
        flywayJobsService.migrate();
        Log.info(flywayJobsService.info().current().getVersion().toString());
    }
}