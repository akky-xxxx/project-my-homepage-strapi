module.exports = ({ env }) => ({
  connection: {
    client: 'mysql',
    connection: {
      socketPath: env('CLOUD_SQL_SOCKET', ''),
      // host: "localhost", // TODO: local 確認用
      // port: 13306, // TODO: local 確認用
      database: env('CLOUD_SQL_NAME', ''),
      user: env('CLOUD_SQL_USERNAME', ''),
      password: env('CLOUD_SQL_PASSWORD', ''),
      ssl: env.bool('DATABASE_SSL', false),
    },
    acquireConnectionTimeout: 30000,
    pool: {
      min: 2,
      max: 6,
      acquireTimeoutMillis: 30000,
      createTimeoutMillis: 30000,
      destroyTimeoutMillis: 30000,
      idleTimeoutMillis: 30000,
      reapIntervalMillis: 30000,
      createRetryIntervalMillis: 2000,
      propagateCreateError: false
    },
    debug: env.bool('IS_DEBUG', false),
  },
});
