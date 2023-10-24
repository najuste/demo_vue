import type { NavigationGuardNext, RouteLocation, RouteLocationNormalized } from "vue-router";

const slidesJSON = "./slides.json"
// export default router
export function fetchSlidesData(to: RouteLocationNormalized, next: NavigationGuardNext) {
    fetch(slidesJSON)
      .then(response => response.json())
      .then(data => {
        // set the slide data in the route meta to be accessible as props
        to.meta.slides = data;
        next();
      })
      .catch(error => {
        console.error('Error fetching slide data:', error);
        next(false);
      });
  }