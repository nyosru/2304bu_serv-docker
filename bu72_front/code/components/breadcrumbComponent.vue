<template>
  <div class="container mb-2">
    <div class="row">
      <div class="col-12" >
        breadcrumbComponent: 
        <!-- <br/> -->
        <!-- CatsAr: {{ CatsAr ?? 'x' }} -->
        <br/>
        CatsAr: {{ CatsAr ?? 'x' }}
        </div>
        </div>
    <div class="row">
      <div class="col-12" v-if="1 == 2">
        cat_id: {{ cat_id ?? 'x' }}
        <br />
        <div style="max-height: 150px; overflow:auto">
          CatsAr: {{ CatsAr ?? 'x' }}
        </div>
        <br />
        <!-- <div style="max-height: 150px; overflow:auto">
          cats: {{ cats ?? 'x' }}
        </div> -->
      </div>
      <div class="col-12">

        <!-- breadcrumb/links: {{ links ?? 0 }} -->
        <!-- <br/> -->
        <!-- breadcrumb2: {{ cat_now ?? 0 }} -->

        <!-- <nav aria-label="breadcrumb" v-if="cats.length > 0" > -->
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb">

            <li class="breadcrumb-item" v-for="c in cats" :key="c.id">
              <NuxtLink :to="'/cat/' + c.id">
                {{ c.name ?? 'x' }}
              </NuxtLink>
            </li>

            <!-- <li class="breadcrumb-item" v-if="cats.c5_id">
              <NuxtLink :to="'/cat/' + cats.c5_id">
                {{ cats.c5_name ?? 'x' }}
              </NuxtLink>
            </li> -->

            <!-- <li class="breadcrumb-item" v-if="cats.c4_id">
              <NuxtLink :to="'/cat/' + cats.c4_id">
                {{ cats.c4_name ?? 'x' }}
              </NuxtLink>
            </li> -->
            <!-- <li class="breadcrumb-item" v-if="cats.c3_id">
              <NuxtLink :to="'/cat/' + cats.c3_id">
                {{ cats.c3_name ?? 'x' }}
              </NuxtLink>
            </li> -->
            <!-- <li class="breadcrumb-item" v-if="cats.c2_id">
              <NuxtLink :to="'/cat/' + cats.c2_id">
                {{ cats.c2_name ?? 'x' }}
              </NuxtLink>
            </li> -->
            <!-- <li class="breadcrumb-item" v-if="cats.id">
              <NuxtLink :to="'/cat/' + cats.id">
                {{ cats.name ?? 'x' }}
              </NuxtLink>
            </li> -->
          </ol>
        </nav>
        <!-- <span v-for="i in 5" :key="i">
        <template v-if="6 - i == 1"></template>
        <template v-else>
          <span v-if="links['c' + (6 - i) + '_id'] > 0">
            <NuxtLink :to="'/cat/' + links['c' + (6 - i) + '_id']">
              {{ links['c' + (6 - i) + '_name'] }}
            </NuxtLink>
          </span>
        </template>
      </span> -->

        <!-- breadcrumb: {{ cats }} -->
      </div>
    </div>
  </div>
</template>

<script setup>
// import { defineProps } from 'vue'

const props = defineProps({
  // links: {
  //   type: Object,
  //   // required: true,
  //   default: {}
  // },
  cat_id: {
    type: String
  }
})

let cats = ref({})

// if (typeof (CatsAr.value) !== 'undefined' && CatsAr.value.length > 0) {
//   cats.value = CatsAr.value;
// }

// const CatsAr = ref({ 1: 2 })
// CatsAr.value = CatsAr.value

// onMounted(async () => {

// const f = async () => {
//   // CatsAr.value = await getCats()
//   CatsAr.value = await loadCats()
//   //   console.log(777, CatsAr.value);
// }

// await f()

const route = useRoute()
const cat_id = route.params.id


const createTreeCat = (cat_id) => {

  // if( CatsAr.value.length == 0 )
  // return false

  let return1 = {}

  if( Object.keys(CatsAr.value).length > 0 ){
  try {

    const a5 = CatsAr.value.find((element) => element.id == cat_id);
    // console.log('a5', a5); // { id: 5, name: 'Mike' }
    return1[5] = a5

    if (a5.cat_up_id != null) {

      const a4 = CatsAr.value.find((element) => element.id == a5.cat_up_id);
      // console.log('a4', a4); // { id: 5, name: 'Mike' }
      return1[4] = a4


      if (a4.cat_up_id != null) {

        const a3 = CatsAr.value.find((element) => element.id == a4.cat_up_id);
        // console.log('a3', a3); // { id: 5, name: 'Mike' }
        return1[3] = a3


        if (a3.cat_up_id != null) {

          const a2 = CatsAr.value.find((element) => element.id == a3.cat_up_id);
          // console.log('a2', a2); // { id: 5, name: 'Mike' }
          return1[2] = a2


          if (a2.cat_up_id != null) {

            const a1 = CatsAr.value.find((element) => element.id == a2.cat_up_id);
            // console.log('a1', a1); // { id: 5, name: 'Mike' }
            return1[1] = a1


          }

        }


      }

    }

  } catch (error) {
    console.error( 'breadCrumb error',789,error);
    return false;
  }
  }

  return return1

}

watchEffect(() => {
  console.log('watchEffect refresh cat bradcramb');
  cats.value = createTreeCat(props.cat_id)
  // cats.value = createTreeCat(cat_id)
})


// })

// useState('cat_now')
// let links = useState('cat_now')
// watch(() => links = useState('cat_now') )

// watch(() => cat_now,
//   (newValue, oldValue) => console.log('tes'),
//   { deep: true }
// )

// watch(() => props.cat_id,
//   (newValue, oldValue) => {
//     console.log('tes',newValue, oldValue) 
//   },
//   { deep: true }
// )

// const links = useCatnow()

// console.log(77,links);

// console.log( 'typeof' , typeof(cats) )

// if( typeof(cats) === 'undefined' ){
//   links = { data: {
//     c1_id: false , c1_name: false ,
//     c2_id: false , c2_name: false ,
//     c3_id: false , c3_name: false ,
//     c4_id: false , c4_name: false ,
//     c5_id: false , c5_name: false
//   } }
// }

</script>
