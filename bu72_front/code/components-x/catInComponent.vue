<template>
  <div>
    <transition>
      <div class="container mb-4" v-if="!pending && catIn.data.length > 0">
        <div class="row">

          <!-- <div class="col-12 text-center">
            <h3>Внутренние каталоги</h3>
          </div> -->

          <div class="col-12 text-center" v-if="catIn.data && catIn.data.length > 0">

            <span v-for="link in catIn.data" :key="link.id" class="me-3">
              <!-- {{ link }} -->
              <NuxtLink :to="'/cat/' + link.id" @click="catIn.data = {}">
                <span class=nobr>{{ link.name }}</span>
              </NuxtLink>
              <span style="font-size:small">&nbsp; </span>
            </span>
          </div>

        </div>
      </div>
    </transition>
  </div>
</template>

<script setup>
import { useRoute } from 'vue-router'

const route = useRoute()
const cat_id = route.params.id

const config = useRuntimeConfig()

// const replace = (str) => str.replace(' ','&nbsp;')

console.log(`${config.public.apiBase}/api/cat-in/` + route.params.id);

// let pending = true
// let data = {}

const { pending, data: catIn, error } = await useAsyncData(
  // const { pending, data: catIn } = await useData(
  // const { pending, data: catIn } = await useFetch(
  // const { data: catNow } = await useFetch(
  'catsIn',
  () =>
    $fetch(
      `${config.public.apiBase}/api/cat-in/` + route.params.id,
      // ,
      // {
      //   params: {
      //     page: page.value
      //   }
      // }
    )
      .catch((error) => {

        //assign response error data to state "errors"
        // errors.value = error.data
        // catNow = {}
        return { data: {} }
      })
  ,
  {
    // watch: [page]
    watch: [route.params.id],
  },
)

// console.log('err', error);
// console.log('err 2', error.value);

</script>

<style>
.nobr {
  white-space: pre;
}
</style>