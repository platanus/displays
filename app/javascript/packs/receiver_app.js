/* global document */

import Vue from 'vue/dist/vue.runtime.esm';
import ReceiverApp from '../components/receiver_app.vue';

document.addEventListener('DOMContentLoaded', () => {
  new Vue({ // eslint-disable-line no-new
    el: '#receiver_app',
    render(createElement) {
      return createElement(ReceiverApp);
    },
  });
});
