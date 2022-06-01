// TODO: local 確認用
// const path = require("path")
// const fs = require("fs")
//
// const serviceAccount = JSON.parse(
//   fs.readFileSync(path.join(__dirname, "../../../../", "terraform/credentials/eloquent-figure-263607-d9c822bc8862.json")) || "",
// )

module.exports = ({ env }) => ({
  upload: {
    config: {
      provider: '@strapi-community/strapi-provider-upload-google-cloud-storage',
      providerOptions: {
        bucketName: env('CLOUD_STORAGE_BUCKET_NAME'),
        baseUrl: `https://storage.googleapis.com/${env('CLOUD_STORAGE_BUCKET_NAME')}`,
        basePath: "files",
        uniform: false,
        // serviceAccount, // TODO: local 確認用
      },
    },
  },
})
