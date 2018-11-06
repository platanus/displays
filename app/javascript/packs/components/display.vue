<template>
  <div class="display">
    <iframe :src="url"
            class="display__iframe"
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
  .display__iframe {
    width: 100vw;
    height: 100vh;
  }
</style>
