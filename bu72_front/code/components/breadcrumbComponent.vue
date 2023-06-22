<template>
  <div class="container mb-2">
    <div class="row" v-if="cat_id == 0">
      <div class="col-12 text-center" v-if="cat_id == 0">
        <template v-for="c in cats0" :key="c.id">
          <NuxtLink :to="'/cat/' + c.id" class="linkDown">
            {{ c.name ?? 'x' }}
          </NuxtLink>
        </template>
      </div>
    </div>
    <div class="row" v-else>
      <div class="col-12">
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb">
            <li class="breadcrumb-item" v-for="c in cats" :key="c.id">
              <!-- с {{  c }} -->
              <NuxtLink :to="'/cat/' + c.id" v-if="c.id && c.id > 0">
                {{ c.name ?? 'x' }}
              </NuxtLink>
            </li>
          </ol>
        </nav>
      </div>

      <div class="col-12 text-center">
        <template v-for="c in catsDown" :key="c.id">
          <NuxtLink :to="'/cat/' + c.id" class="linkDown">
            {{ c.name ?? 'x' }}
          </NuxtLink>
        </template>
      </div>
    </div>

  </div>
</template>

<style>
.linkDown {
  margin-right: 1rem;
}
</style>

<script setup>

// const props = defineProps({
//   cat_id: {
//     type: String
//   }
// })

// const route = useRoute()
// const cat_id = route.params.id

// хлебные крошки
const cats = ref({})
// каталоги ниже текущего
const catsDown = ref([])

const route = useRoute()
const cat_id = route.params.id

const dataCats = ref({})

dataCats.value = await loadCats()

const createTreeCat0 = async (cat_id) => {

  // dataCats.value = await loadCats()
  // createListCatDown(dataCats.value['_value']['data'], cat_id)
  // createListCatDown(dataCats.value['_value']['data'], cat_id)
  await createTreeCat(cat_id)
  await createTreeCatStart()
  await createListCatDown(cat_id)
  // return  
  // return {}
}

const createTreeCat = async (cat_id) => {

  dataCats.value = await loadCats()

  // console.log('dataCats.value', dataCats.value);

  let return1 = {}
  // return return1

  console.log('dataCats',dataCats.value['_value']);

  // if ( typeof(dataCats.value['_value']['data']) !== 'undefined' && Object.keys(dataCats.value['_value']['data']).length > 0) {
  if (dataCats.value['_value'] != null && Object.keys(dataCats.value['_value']['data']).length > 0) {
    try {

      const a5 = dataCats.value['_value']['data'].find((element) => element.id == cat_id);
      // console.log('a5', a5); // { id: 5, name: 'Mike' }
      return1[5] = a5

      if (typeof (a5) !== 'undefined' && a5.cat_up_id != null) {

        const a4 = dataCats.value['_value']['data'].find((element) => element.id == a5.cat_up_id);
        // console.log('a4', a4); // { id: 5, name: 'Mike' }
        return1[4] = a4


        if (typeof (a4) !== 'undefined' && a4.cat_up_id != null) {

          const a3 = dataCats.value['_value']['data'].find((element) => element.id == a4.cat_up_id);
          // console.log('a3', a3); // { id: 5, name: 'Mike' }
          return1[3] = a3


          if (typeof (a3) !== 'undefined' && a3.cat_up_id != null) {

            const a2 = dataCats.value['_value']['data'].find((element) => element.id == a3.cat_up_id);
            // console.log('a2', a2); // { id: 5, name: 'Mike' }
            return1[2] = a2


            if (typeof (a2) !== 'undefined' && a2.cat_up_id != null) {

              const a1 = dataCats.value['_value']['data'].find((element) => element.id == a2.cat_up_id);
              // console.log('a1', a1); // { id: 5, name: 'Mike' }
              return1[1] = a1

            }

          }

        }

      }

    } catch (error) {
      console.error('breadCrumb error', 789, error);
      // return false;
    }
  }

  cats.value = return1
  return {}
  // return await return1

}

const cats0 = ref([])

const createTreeCatStart = async (cat_id) => {

  dataCats.value = await loadCats()

  // console.log('dataCats.value',dataCats.value);

  let return1 = []
  // return return1

  // if ( typeof(dataCats.value['_value']['data']) !== 'undefined' && Object.keys(dataCats.value['_value']['data']).length > 0) {
  if (Object.keys(dataCats.value['_value']['data']).length > 0) {
    try {

      // const a5 = dataCats.value['_value']['data'].find((element) => element.cat_up_id === null );
      return1 = dataCats.value['_value']['data'].filter((element) => element.cat_up_id === null);
      // console.log('a5', a5); // { id: 5, name: 'Mike' }
      // return1.push(a5)

    } catch (error) {
      console.error('breadCrumb error', 789, error);
      // return false;
    }
  }

  cats0.value = return1
  return {}
  // return await return1

}


const createListCatDown = async (show_cat_id = 0) => {

  // console.log('createListCatDown', show_cat_id);

  // if (show_cat_id == 0) {
  //   // console.log(999888);    
  //   catsDown.value = dataCats.filter(item => {
  //     // if( item.id > 0 ){
  //     console.log(100, item.cat_up_id === null );
  //     return item.cat_up_id == null
  //     // }else{
  //     //   return false
  //     // }
  //   });
  // } else {
  //   catsDown.value = dataCats.filter(item => item.cat_up_id == cat_id);
  // }

  // // var ee = await loadCats()

  // // catsDown.value = { 1 : 2}

  // // var tt = ee['_value']['data'].map(item => {
  // //   // if (ee.value['_value']['data'][item].cat_up_id == cat_id) {
  // //   if (ee['_value']['data'][item].cat_up_id == cat_id) {
  // //     return { ...item }
  // //     // return { ...item, role: 'admin' }
  // //   }

  // //   // return { ...item, role: 'user' }
  // // });

  // // catsDown.value = tt
  // // // catsDown.value = returnData
  // // // return returnData



  dataCats.value = await loadCats()

  // console.log('dataCats.value',dataCats.value);

  let return1 = []
  // return return1

  // if ( typeof(dataCats.value['_value']['data']) !== 'undefined' && Object.keys(dataCats.value['_value']['data']).length > 0) {
  if (Object.keys(dataCats.value['_value']['data']).length > 0) {
    try {

      // const a5 = dataCats.value['_value']['data'].find((element) => element.cat_up_id === null );
      catsDown.value = dataCats.value['_value']['data'].filter((element) => element.cat_up_id == show_cat_id);
      // console.log('a5', a5); // { id: 5, name: 'Mike' }
      // return1.push(a5)

    } catch (error) {
      console.error('breadCrumb error', 789, error);
      // return false;
    }
  }

  // cats0.value = return1
  // return {}
  // return await return1


}



// createTreeCat0(props.cat_id)
createTreeCat0(cat_id)

// createListCatDown(props.cat_id)

watchEffect(() => {
  // createTreeCat0(props.cat_id)
  createTreeCat0(cat_id)
  // createListCatDown(props.cat_id)
})

</script>
