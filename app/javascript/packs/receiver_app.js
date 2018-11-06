/* global document */

import Vue from 'vue/dist/vue.esm';
import Display from './components/display.vue';

document.addEventListener('DOMContentLoaded', () => {
  new Vue({ // eslint-disable-line no-new
    el: '#receiver_app',
    components: { Display },
  });
});
