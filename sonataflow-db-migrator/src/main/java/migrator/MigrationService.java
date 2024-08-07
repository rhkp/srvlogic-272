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

    private void migrateDB(Flyway flywayService, Boolean clean, String serviceName) {
        Log.info("Migrating " + serviceName);
        if (clean) {
            Log.info("Cleaned the " + serviceName);
            flywayService.clean();
        }
        flywayService.migrate();
        Log.info(flywayService.info().current().getVersion().toString());
    }

    public void migrateDataIndex() {
        migrateDB(flywayDataIndex, cleanDataIndex, "data-index");
    }

    public void migrateJobsService() {
        migrateDB(flywayJobsService, cleanJobsService, "jobs-service");
    }
}