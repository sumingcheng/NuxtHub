// https://nuxt.com/docs/api/configuration/nuxt-config

export default defineNuxtConfig({
  devtools: { enabled: true },
  app: {
    // pageTransition: { name: 'page', mode: 'out-in' }
  },
  plugins: ['~/plugins/element-plus.ts', '~/plugins/id-provider.ts'],
  css: ['~/assets/_reset.scss', '~/assets/index.scss', 'element-plus/dist/index.css'],
  modules: ['nuxt-icon'],
  build: {
    transpile: ['element-plus/es']
  }
})
