/* global document */

import Vue from 'vue/dist/vue.runtime.esm';
import DisplayContainer from '../components/display_container.vue';

document.addEventListener('DOMContentLoaded', () => {
  new Vue({ // eslint-disable-line no-new
    el: '#receiver_app',
    components: { DisplayContainer },
    render(createElement) {
      return createElement(DisplayContainer);
    },
  });
});
