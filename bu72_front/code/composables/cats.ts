// // import { useState } from "#app";
// import { ref } from "vue";

// export const loadCatsPedding = true;

// import axios from "@nuxtjs/axios"

export const CatsAr = ref({});
// export const CatsPendong = ref(false);

export const loadCats = async () => {
  try {
    if (Object.keys(CatsAr.value).length > 0) {
      console.log("вернули каты что загружены ранее");
      // console.log("77",CatsAr.value);
      return CatsAr.value;
    } else {
      console.log("грузим новые каталоги 0");
      return await loadCats1();
    }
  } catch (error) {
    return { error: error };
  }
};

export const loadCats1 = async () => {
  try {
    const config = useRuntimeConfig();
    // console.log("");
    // console.log("comp cats.js > loadCats1");
    // console.log(`${config.public.apiBase}/api/cats`);

    const { data } = await useFetch(`${config.public.apiBase}/api/cats`);

    // console.log("data loadiing cat", data.value);
    // console.log("data loadiing cat", data);

    // if (data.length == 0) {
    //   const { data, error } = await useLazyFetch(
    //     `${config.public.apiBase}/api/cats`
    //   );
    //   console.log("err", error.value);

    //   // CatsPendong.value = pending

    //   if (data.length == 0) {
    //     const { data } = await useAsyncData("catts", () =>
    //       $fetch(`${config.public.apiBase}/api/cats`, { method: "GET" })
    //     );
    //   }
    // }

    // CatsAr.value = data.value;
    CatsAr.value = await data;

    // return CatsAr.value;
    return data;
  } catch (error) {
    return { status: "error", error };
  }
};

// // // const isMyValueEmpty = computed(() => {
// // //     return var.trim() === '';
// // //   });

// const listCats = ref({});

// export const getCats = async () => {
//   try {
//     if (listCats.value !== null && listCats.value.length > 0) {
//       console.log("0077 каталоги уже есть", listCats.value);
//       //       return listCats.value;
//     }
//     // else {
//     //       // }
//     console.log("007711 каталоги новенькое");
//     listCats.value = await loadCats();
//     //       // console.log("useCats", 32, dataCats.length, dataCats);
//     // return await listCats.value;
//     return listCats.value;
//     //     }
//     return {};
//   } catch (error) {
//     //     console.error(888);
//     //     listCats.value = await loadCats();
//     //     return await listCats.value;
//     return {};
//   }
// };

// // // export function useB () {
// // const useCats = async () => {
// //   //   const res = useState("cats");
// //   //   if (res.value.length > 0) {
// //   //     console.log(0, "useCats", res);
// //   //     return res;
// //   //   }

// //   let dataCats = {};
// //   //   dataCats = useState("cats");

// //   //   if ( dataCats != 'no' ){
// //   //     console.log(778899, dataCats);
// //   //     console.log(778899, dataCats.value);
// //   //     return dataCats
// //   //   }else{
// //   //     console.log(778899111);
// //   //   }

// //   dataCats = await loadCats();
// //   console.log("useCats", 32, dataCats.length, dataCats);

// //   return await useState("cats", () => dataCats);
// // };

// // export { useCats };

// // // function useB () {
// // //   return 'b'
// // // }

// // // function _useC () {
// // //   return 'c'
// // // }

// // // export const useD = () => {
// // //   return 'd'
// // // }

// // // export { useB, _useC as useC }

// // // export default function () {
// // //   return useState('foo', () => 'bar')
// // // }

await loadCats();
await loadCats();
