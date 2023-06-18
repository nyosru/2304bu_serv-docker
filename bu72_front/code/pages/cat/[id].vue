<template>
  <div>

    <div class="container mt-3">
      <div class="row">
        <div class="col-12">
          <a href="#" @click.prevent="loadingData" >загрузить данные</a>
          </div>
        <div class="col-12">
          <!-- catNow: {{ catNow ?? 'x'}} -->
          <br />
          <br />
          <div style="max-height: 50px; font-size:10px; font-family:arial;overflow:auto;">
            CatsAr: {{ CatsAr ?? 'x' }}
            </div>
          <div style="max-height: 50px; font-size:10px; font-family:arial;overflow:auto;">
            <!-- showListCats1: {{ showListCats.pending ?? 'x' }}          <br/> -->
            <!-- showListCats2: {{ showListCats.data ?? 'x' }}          <br/> -->
            <!-- CatsPendong: {{ CatsPendong }} <br/> -->
            showListCats: {{ showListCats ?? 'x' }}
          </div>
          <br />
          <!-- loadCatsPedding: {{ loadCatsPedding??'x' }} -->
          <!-- <br /> -->
          <br />
          <!-- goodsLoading: {{ goodsLoading ?? 'x'}} -->
          <!-- <br/> -->
          <!-- catsData1: {{ catsData1 ?? 'x' }} -->
        </div>

        
      </div>

      <div class="row">
          <div class="col-md-12">

            <breadcrumb-component xlinks="catNow" :cat_id="(cat_id ?? '')" />

          </div>
        </div>
    </div>




    <template v-if="1 == 2">
      <div class="container mt-3">


        <div class="row">
          <div class="col-12">
            <cat-in-component />
          </div>
        </div>

        <div class="row">
          <div class="col-12 mb-4">
            <nav-filter-action-component :filter="filter" />
          </div>
        </div>

        <div class="row" v-if="1 == 2">
          <div class="col-md-12">
            <button @click="s1 = !s1">show/hide</button>
            <div v-if="s1">
              <hr />
              cat/id
              <hr />

              <!-- <nav-cats-component /> -->
              YE!! {{ cat_id ?? 'x' }}
              <br />
              goodsLoading {{ goodsLoading ?? 'x' }}
              <br />
              <!-- catNowLoading: {{ catNowLoading }} -->
              <!-- <br /> -->
              <div class="mh">catNow: {{ catNow ?? 'x' }}</div>
              <div class="mh">goods: {{ goods ?? 'x' }}</div>
              <!-- <div class="mh">cat_now: {{ cat_now ?? 'x' }}</div> -->
              <!-- <div class="mh">counter: {{ counter ?? 'x' }}</div> -->
              <!-- <div class="mh">catNow: {{ counter ?? 'x' }}</div> -->
              <br />
              <!-- <div class="mh">goods: {{ goods ?? 'x' }}</div> -->
            </div>
          </div>
        </div>

        <div class="row" v-if="1 == 2">
          <div class="col-md-12">
            <h2>товары</h2>
          </div>
        </div>

      </div>

      <div class="container-fluid mb-5">
        <div class="row" v-if="goodsLoading">
          <div class="col-12 text-center">... загружаю ...</div>
          <div class="col-12 col-md-4 col-lg-3 text-center" v-for="o in 20" :key="o">
            <svg width="70%" height="150" viewBox="0 0 5 5" xmlns="http://www.w3.org/2000/svg">
              <rect width="5" height="5" fill="#999999" />
            </svg>
            <br />
            <br />
            <br />
          </div>
        </div>

        <div class="row" v-else>
          <!-- <template v-if="goods.data && goods.data.length > 0 " > -->
          <!-- <div class="col-12 col-md-4 col-lg-3 col-xl-2" v-for="g in goods.data" :key="g.id"> -->
          <!-- <good-mini-component :g="g" :propCat="cat_id" /> -->
          <!-- </div> -->
          <!-- </template> -->
        </div>
      </div>
    </template>
  </div>
</template>

<script setup>
// import { useRoute } from 'vue-router'

// import { setMaxIdleHTTPParsers } from 'http';

const route = useRoute()
const cat_id = route.params.id

// const config = useRuntimeConfig()

// // console.log('config',config);

// // const filter = ref({ sell: false, buy: false, renta: false, need_renta: false })
// const filter = ref({})


const showListCats = ref({})
// showListCats.value = await getCats()
showListCats.value = await loadCats()
// await loadCats()

const loadingData = async () => {
  showListCats.value = await loadCats()
  console.log('showListCats.value',showListCats.value);
}

// showListCats.value = await loadCats()

// // const { getCats } = useCats()
// // // const catsData1 = catsData()
// // const catsData1 = getCats()

// // let filter0 = {}
// // filter0 = {
// //   mounted: (el) => {
// //     // сделать что-нибудь с элементом
// //     filter0 = JSON.parse(localStorage.getItem('filter')) || []
// //     filter.value = filter0
// //   }

// // }




// // import { filter } from '~/components/navFilterActionComponent.vue';

// // const { data: goods } = await useFetch(
// //   () => `${config.public.apiBase}/api/goodFromCat/` + cat_id,
// //   //, { params: { token: 123 } }
// // )

// // try {

// // console.log(`${config.public.apiBase}/api/cat/` + route.params.id);

// // console.log(config.public.apiBase);
// // console.log(`${config.public.apiBase}/api/cat/` + route.params.id,);

// // const { data: catNow } = await useFetch(
// //   // () => `${config.public.apiBase}/api/cat/` + cat_id,
// //   () => `${config.public.apiBase}/api/cat/` + route.params.id
// // // //   //,
// // // //   //, { params: { token: 123 } }
// // )

// const s1 = ref(false)

// // let catNow = {}

// // try {

// const { data: catNow, pending, error } = await useAsyncData(
//   // const { data: catNow } = await useFetch(
//   'cats',
//   () =>
//     $fetch(
//       `${config.public.apiBase}/api/cat/` + route.params.id,
//       // ,
//       // {
//       //   params: {
//       //     page: page.value
//       //   }
//       // }
//     )

//       // .then(() => {
//       //   //redirect
//       //   // router.push({ path: "/posts" });
//       // })
//       .catch((error) => {

//         //assign response error data to state "errors"
//         // errors.value = error.data
//         // catNow = {}
//         return { data: {} }
//       })

//   ,
//   {
//     // watch: [page]
//     watch: [route.params.id],
//   },
// )

// console.log('catNow', catNow, '/', pending, '/', error);

// // } catch (error) {
// //   const catNow = {}
// // }

// const { pending: goodsLoading, data: goods, error: err1 } = await useAsyncData(
//   'goods',
//   () =>
//     $fetch(
//       `${config.public.apiBase}/api/goodFromCat/` + route.params.id
//       ,
//       {
//         params: {
//           // page: page.value
//           filter: filter.value
//         }
//       }
//     )
//   //     .catch((error) => {
//   // //assign response error data to state "errors"
//   // // errors.value = error.data
//   // // catNow = {}
//   // return { data: {} }
//   // })
//   ,
//   {
//     // watch: [page]
//     watch: [route.params.id, filter.value],
//   },
// )

// console.log('err1', err1.value);

// // // // watchEffect(()=>{
// // useState('cat_now', () => catNow)
// // const counter = useState('cat_now', () => catNow)
// // // })

// // } catch (error) {
// // const counter = useState('cat_now', () => { data: [{ id:0,name:'','cat_up_id':null}] } )
// // }
</script>

<style scoped>
.mh {
  max-height: 60px;
  overflow: auto;
  display: block;
  border: 1px solid green;
  padding: 5px;
}
</style>
