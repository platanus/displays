/* global document */

import Vue from 'vue/dist/vue.runtime.esm';
import Display from './components/display.vue';

document.addEventListener('DOMContentLoaded', () => {
  new Vue({ // eslint-disable-line no-new
    el: '#receiver_app',
    components: { Display },
    render(createElement) {
      return createElement(Display);
    },
  });
});
