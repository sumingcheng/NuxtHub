import { customAlphabet } from 'nanoid';
import { defineNuxtPlugin } from '#app';

export default defineNuxtPlugin(nuxtApp => {
  const nanoid = customAlphabet('1234567890abcdefgh', 10);

  nuxtApp.vueApp.provide('ID_INJECTION_KEY', {
    prefix: nanoid(),
    current: 0
  });
});
