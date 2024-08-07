/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

SET SEARCH_PATH="$JOBS_SERVICE_SCHEMA";

CREATE TYPE JOB_STATUS AS ENUM
(
  'ERROR',
  'EXECUTED',
  'SCHEDULED',
  'RETRY',
  'CANCELED'
);

CREATE TYPE JOB_TYPE AS ENUM
(
  'HTTP'
);

CREATE TABLE job_details
(
  id VARCHAR(40) PRIMARY KEY,
  correlation_id VARCHAR(40),
  status JOB_STATUS,
  last_update TIMESTAMPTZ,
  retries INT4,
  execution_counter INT4,
  scheduled_id VARCHAR(40),
  payload JSONB,
  type JOB_TYPE,
  priority INT4,
  recipient JSONB,
  trigger JSONB
);

CREATE INDEX status_date ON job_details
(
  status,
  ((trigger->>'nextFireTime')::INT8)
);