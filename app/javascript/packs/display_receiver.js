/* global document */

import Vue from 'vue/dist/vue.esm';
import RemoteIframe from '../components/remote_iframe.vue';

document.addEventListener('DOMContentLoaded', () => {
  new Vue({ // eslint-disable-line no-new
    el: '#receiver_app',
    components: { RemoteIframe },
  });
});
