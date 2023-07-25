import {useAsyncData} from "nuxt/app";

export const goodsInCatId = ref(0)
export const { data: goods } = await useAsyncData(
    'goodsInCat',
    // () => $fetch('https://fakeApi.com/posts', {
    () => $fetch('https://api.bu72.local/api/goodFromCat/'+goodsInCatId.value, {
        // params: {
        //     // page: page.value
        //     page: goodsInCatId.value
        // }
    }), {
        // watch: [page]
        watch: [goodsInCatId]
    }
)

// // // import { useState } from "#app";
// // import { ref } from "vue";
//
// // export const loadCatsPedding = true;
//
// // import axios from "@nuxtjs/axios"
//
// export const CatsAr = ref({});
// // export const CatsPendong = ref(false);
//
// export const loadCatsLoading = ref(false);
//
// export const loadCats = async () => {
//   try {
//     if (
//       Object.keys(CatsAr.value).length > 0 &&
//       loadCatsLoading.value == false
//     ) {
//       console.log("вернули каты что загружены ранее");
//       // console.log("77",CatsAr.value);
//       return CatsAr.value;
//     } else {
//       console.log("грузим новые каталоги 0");
//       loadCatsLoading.value = true;
//       let rr = await loadCats1();
//       loadCatsLoading.value = false;
//       return rr;
//     }
//   } catch (error) {
//     return { error: error };
//   }
// };
// export const loadCatsaaa = () => {
//   try {
//     if (
//       Object.keys(CatsAr.value).length > 0 &&
//       loadCatsLoading.value == false
//     ) {
//       console.log("вернули каты что загружены ранее");
//       // console.log("77",CatsAr.value);
//       return CatsAr.value;
//     } else {
//       console.log("грузим новые каталоги 0");
//       loadCatsLoading.value = true;
//       let rr = loadCats1();
//       loadCatsLoading.value = false;
//       return rr;
//     }
//   } catch (error) {
//     return { error: error };
//   }
// };
//
// export const loadCats1 = async () => {
//   try {
//     // // const config = useRuntimeConfig();
//     // // console.log("");
//     // // console.log("comp cats.js > loadCats1");
//     // // console.log(`${config.public.apiBase}/api/cats`);
//
//     // // const { data } = await useFetch(`${config.public.apiBase}/api/cats`);
//     // console.log('useFetch',`https://api.${document.location.host}/api/posts`);
//     // const { data } = await useFetch(`https://api.${document.location.host}/api/posts`);
//
//     // console.log(
//     //   "77 22 composables/cats document.location.host",
//     //   document.location.host
//     // );
//
//     let uri2 = `https://api.${document.location.host}/api/cats`;
//
//     // для локальных тестов
//     if (document.location.host == "localhost:3000") {
//       uri2 = `https://api.bu72.local/api/cats`;
//     }
//
//     // try {
//     const { data } = await useFetch(uri2)
//     // }catch (e) {
//     //   alert('error: '+e)
//     // }
//
//
//     // console.log("data loadiing cat", data.value);
//     // console.log("data loadiing cat", data);
//
//     // if (data.length == 0) {
//     //   const { data, error } = await useLazyFetch(
//     //     `${config.public.apiBase}/api/cats`
//     //   );
//     //   console.log("err", error.value);
//
//     //   // CatsPendong.value = pending
//
//     //   if (data.length == 0) {
//     //     const { data } = await useAsyncData("catts", () =>
//     //       $fetch(`${config.public.apiBase}/api/cats`, { method: "GET" })
//     //     );
//     //   }
//     // }
//
//     // CatsAr.value = data.value;
//     CatsAr.value = await data;
//
//     console.log('CatsAr')
//
//     // return CatsAr.value;
//     return data;
//   } catch (error) {
//     return { status: "error", error };
//   }
// };
//
// export const loadCats1aaa = () => {
//   try {
//
//     let uri2 = `https://api.${document.location.host}/api/cats`;
//
//     // для локальных тестов
//     if (document.location.host == "localhost:3000") {
//       uri2 = `https://api.bu72.local/api/cats`;
//     }
//
//     // try {
//     const { data } = useFetch(uri2)
//
//     // CatsAr.value = data.value;
//     CatsAr.value = data;
//
//     // return CatsAr.value;
//     return data;
//   } catch (error) {
//     return { status: "error", error };
//   }
// };
//
// const dataCats0 = ref({});
//
// export const createTreeCatStart = async (cat_id = null) => {
//   dataCats0.value = await loadCats();
//
//   // console.log('dataCats.value',dataCats.value);
//
//   let return1 = [];
//   // return return1
//
//   // if ( typeof(dataCats.value['_value']['data']) !== 'undefined' && Object.keys(dataCats.value['_value']['data']).length > 0) {
//   if (Object.keys(dataCats0.value["_value"]["data"]).length > 0) {
//     try {
//       // const a5 = dataCats.value['_value']['data'].find((element) => element.cat_up_id === null );
//       // return1 = dataCats0.value['_value']['data'].filter((element) => element.cat_up_id === null);
//       return1 = dataCats0.value["_value"]["data"].filter(
//         (element) => element.cat_up_id === cat_id
//       );
//       // console.log('a5', a5); // { id: 5, name: 'Mike' }
//       // return1.push(a5)
//     } catch (error) {
//       console.error("breadCrumb error", 789, error);
//       // return false;
//     }
//   }
//
//   // cats0.value = return1
//   return return1;
//   // return {}
//   // return await return1
// };
//
// export const createTreeCatStartaa = (cat_id = null) => {
//   dataCats0.value = loadCats();
//
//   // console.log('dataCats.value',dataCats.value);
//
//   let return1 = [];
//   // return return1
//
//   // if ( typeof(dataCats.value['_value']['data']) !== 'undefined' && Object.keys(dataCats.value['_value']['data']).length > 0) {
//   if (Object.keys(dataCats0.value["_value"]["data"]).length > 0) {
//     try {
//       // const a5 = dataCats.value['_value']['data'].find((element) => element.cat_up_id === null );
//       // return1 = dataCats0.value['_value']['data'].filter((element) => element.cat_up_id === null);
//       return1 = dataCats0.value["_value"]["data"].filter(
//         (element) => element.cat_up_id === cat_id
//       );
//       // console.log('a5', a5); // { id: 5, name: 'Mike' }
//       // return1.push(a5)
//     } catch (error) {
//       console.error("breadCrumb error", 789, error);
//       // return false;
//     }
//   }
//
//   // cats0.value = return1
//   return return1;
//   // return {}
//   // return await return1
// };
