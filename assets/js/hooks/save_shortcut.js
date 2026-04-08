
export default {
  mounted() {

    this.handler = (e) => {
      if ((e.metaKey || e.ctrlKey) && e.key === "s") {
        e.preventDefault()
        this.el.querySelector("button[type=submit]").click()
      }
    }
    window.addEventListener("keydown", this.handler)
  },
  destroyed() {
    window.removeEventListener("keydown", this.handler)
  }
}