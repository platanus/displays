<template>
  <div class="display-container">
    <iframe :src="url"
            class="display-container__iframe"
            scrolling="no"
            frameborder="0"
            allowfullscreen></iframe>
  </div>
</template>

<script>
export default {
  data() {
    return {
      url: null,
    };
  },
  created() {
    this.setupStream();
  },
  methods: {
    setupStream() {
      const es = new EventSource(`${location.href}/watch`);
      const that = this;

      es.addEventListener('display_updated', (event) => {
        const data = JSON.parse(event.data);
        that.url = data.url;
      }, false);

      es.addEventListener('display_connected', (event) => {
        const data = JSON.parse(event.data);
        that.url = data.url;
      }, false);
    },
  },
};
</script>

<style scoped>
  .display-container__iframe {
    width: 100vw;
    height: 100vh;
  }
</style>
