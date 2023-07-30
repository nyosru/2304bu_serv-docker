import { _ as __nuxt_component_0$1 } from './nuxt-link-691ee40a.mjs';
import { ref, withAsyncContext, unref, useSSRContext, computed, reactive, watchEffect, mergeProps, withCtx, createTextVNode, toDisplayString, toRef, getCurrentInstance, onServerPrefetch } from 'vue';
import { _ as _export_sfc, b as useRoute, a as useRuntimeConfig, u as useNuxtApp, c as createError } from '../server.mjs';
import { hash } from 'ohash';
import { ssrRenderAttrs, ssrRenderStyle, ssrInterpolate, ssrRenderComponent, ssrRenderList } from 'vue/server-renderer';
import 'ufo';
import 'ofetch';
import 'hookable';
import 'unctx';
import 'h3';
import '@unhead/ssr';
import 'unhead';
import '@unhead/shared';
import 'vue-router';
import '../../nitro/node-server.mjs';
import 'node-fetch-native/polyfill';
import 'node:http';
import 'node:https';
import 'destr';
import 'unenv/runtime/fetch/index';
import 'scule';
import 'klona';
import 'unstorage';
import 'radix3';
import 'node:fs';
import 'node:url';
import 'pathe';

const getDefault = () => null;
function useAsyncData(...args) {
  var _a, _b, _c, _d, _e;
  const autoKey = typeof args[args.length - 1] === "string" ? args.pop() : void 0;
  if (typeof args[0] !== "string") {
    args.unshift(autoKey);
  }
  let [key, handler, options = {}] = args;
  if (typeof key !== "string") {
    throw new TypeError("[nuxt] [asyncData] key must be a string.");
  }
  if (typeof handler !== "function") {
    throw new TypeError("[nuxt] [asyncData] handler must be a function.");
  }
  options.server = (_a = options.server) != null ? _a : true;
  options.default = (_b = options.default) != null ? _b : getDefault;
  options.lazy = (_c = options.lazy) != null ? _c : false;
  options.immediate = (_d = options.immediate) != null ? _d : true;
  const nuxt = useNuxtApp();
  const getCachedData = () => nuxt.isHydrating ? nuxt.payload.data[key] : nuxt.static.data[key];
  const hasCachedData = () => getCachedData() !== void 0;
  if (!nuxt._asyncData[key]) {
    nuxt._asyncData[key] = {
      data: ref((_e = getCachedData()) != null ? _e : options.default()),
      pending: ref(!hasCachedData()),
      error: toRef(nuxt.payload._errors, key)
    };
  }
  const asyncData = { ...nuxt._asyncData[key] };
  asyncData.refresh = asyncData.execute = (opts = {}) => {
    if (nuxt._asyncDataPromises[key]) {
      if (opts.dedupe === false) {
        return nuxt._asyncDataPromises[key];
      }
      nuxt._asyncDataPromises[key].cancelled = true;
    }
    if ((opts._initial || nuxt.isHydrating && opts._initial !== false) && hasCachedData()) {
      return getCachedData();
    }
    asyncData.pending.value = true;
    const promise = new Promise(
      (resolve, reject) => {
        try {
          resolve(handler(nuxt));
        } catch (err) {
          reject(err);
        }
      }
    ).then((_result) => {
      if (promise.cancelled) {
        return nuxt._asyncDataPromises[key];
      }
      let result = _result;
      if (options.transform) {
        result = options.transform(_result);
      }
      if (options.pick) {
        result = pick(result, options.pick);
      }
      asyncData.data.value = result;
      asyncData.error.value = null;
    }).catch((error) => {
      if (promise.cancelled) {
        return nuxt._asyncDataPromises[key];
      }
      asyncData.error.value = error;
      asyncData.data.value = unref(options.default());
    }).finally(() => {
      if (promise.cancelled) {
        return;
      }
      asyncData.pending.value = false;
      nuxt.payload.data[key] = asyncData.data.value;
      if (asyncData.error.value) {
        nuxt.payload._errors[key] = createError(asyncData.error.value);
      }
      delete nuxt._asyncDataPromises[key];
    });
    nuxt._asyncDataPromises[key] = promise;
    return nuxt._asyncDataPromises[key];
  };
  const initialFetch = () => asyncData.refresh({ _initial: true });
  const fetchOnServer = options.server !== false && nuxt.payload.serverRendered;
  if (fetchOnServer && options.immediate) {
    const promise = initialFetch();
    if (getCurrentInstance()) {
      onServerPrefetch(() => promise);
    } else {
      nuxt.hook("app:created", () => promise);
    }
  }
  const asyncDataPromise = Promise.resolve(nuxt._asyncDataPromises[key]).then(() => asyncData);
  Object.assign(asyncDataPromise, asyncData);
  return asyncDataPromise;
}
function pick(obj, keys) {
  const newObj = {};
  for (const key of keys) {
    newObj[key] = obj[key];
  }
  return newObj;
}
function useRequestFetch() {
  var _a;
  const event = (_a = useNuxtApp().ssrContext) == null ? void 0 : _a.event;
  return (event == null ? void 0 : event.$fetch) || globalThis.$fetch;
}
function useFetch(request, arg1, arg2) {
  const [opts = {}, autoKey] = typeof arg1 === "string" ? [{}, arg1] : [arg1, arg2];
  const _key = opts.key || hash([autoKey, unref(opts.baseURL), typeof request === "string" ? request : "", unref(opts.params || opts.query)]);
  if (!_key || typeof _key !== "string") {
    throw new TypeError("[nuxt] [useFetch] key must be a string: " + _key);
  }
  if (!request) {
    throw new Error("[nuxt] [useFetch] request is missing.");
  }
  const key = _key === autoKey ? "$f" + _key : _key;
  const _request = computed(() => {
    let r = request;
    if (typeof r === "function") {
      r = r();
    }
    return unref(r);
  });
  if (!opts.baseURL && typeof _request.value === "string" && _request.value.startsWith("//")) {
    throw new Error('[nuxt] [useFetch] the request URL must not start with "//".');
  }
  const {
    server,
    lazy,
    default: defaultFn,
    transform,
    pick: pick2,
    watch,
    immediate,
    ...fetchOptions
  } = opts;
  const _fetchOptions = reactive({
    ...fetchOptions,
    cache: typeof opts.cache === "boolean" ? void 0 : opts.cache
  });
  const _asyncDataOptions = {
    server,
    lazy,
    default: defaultFn,
    transform,
    pick: pick2,
    immediate,
    watch: watch === false ? [] : [_fetchOptions, _request, ...watch || []]
  };
  let controller;
  const asyncData = useAsyncData(key, () => {
    var _a;
    (_a = controller == null ? void 0 : controller.abort) == null ? void 0 : _a.call(controller);
    controller = typeof AbortController !== "undefined" ? new AbortController() : {};
    const isLocalFetch = typeof _request.value === "string" && _request.value.startsWith("/");
    let _$fetch = opts.$fetch || globalThis.$fetch;
    if (!opts.$fetch && isLocalFetch) {
      _$fetch = useRequestFetch();
    }
    return _$fetch(_request.value, { signal: controller.signal, ..._fetchOptions });
  }, _asyncDataOptions);
  return asyncData;
}
const CatsAr = ref({});
const loadCats = async () => {
  try {
    if (Object.keys(CatsAr.value).length > 0) {
      console.log("\u0432\u0435\u0440\u043D\u0443\u043B\u0438 \u043A\u0430\u0442\u044B \u0447\u0442\u043E \u0437\u0430\u0433\u0440\u0443\u0436\u0435\u043D\u044B \u0440\u0430\u043D\u0435\u0435");
      return CatsAr.value;
    } else {
      console.log("\u0433\u0440\u0443\u0437\u0438\u043C \u043D\u043E\u0432\u044B\u0435 \u043A\u0430\u0442\u0430\u043B\u043E\u0433\u0438 0");
      return await loadCats1();
    }
  } catch (error) {
    return { error };
  }
};
const loadCats1 = async () => {
  try {
    const config = /* @__PURE__ */ useRuntimeConfig();
    console.log("");
    console.log("comp cats.js > loadCats1");
    console.log(`${config.public.apiBase}/api/cats`);
    const { data } = await useFetch(`${config.public.apiBase}/api/cats`, "$isDHv5vHhq");
    console.log("data loadiing cat", data.value);
    CatsAr.value = data;
    return await data.value;
  } catch (error) {
    return { status: "error", error };
  }
};
const _sfc_main$1 = {
  __name: "breadcrumbComponent",
  __ssrInlineRender: true,
  props: {
    // links: {
    //   type: Object,
    //   // required: true,
    //   default: {}
    // },
    cat_id: {
      type: String
    }
  },
  setup(__props) {
    const props = __props;
    let cats = ref({});
    const route = useRoute();
    route.params.id;
    const createTreeCat = (cat_id) => {
      let return1 = {};
      if (Object.keys(CatsAr.value).length > 0) {
        try {
          const a5 = CatsAr.value.find((element) => element.id == cat_id);
          return1[5] = a5;
          if (a5.cat_up_id != null) {
            const a4 = CatsAr.value.find((element) => element.id == a5.cat_up_id);
            return1[4] = a4;
            if (a4.cat_up_id != null) {
              const a3 = CatsAr.value.find((element) => element.id == a4.cat_up_id);
              return1[3] = a3;
              if (a3.cat_up_id != null) {
                const a2 = CatsAr.value.find((element) => element.id == a3.cat_up_id);
                return1[2] = a2;
                if (a2.cat_up_id != null) {
                  const a1 = CatsAr.value.find((element) => element.id == a2.cat_up_id);
                  return1[1] = a1;
                }
              }
            }
          }
        } catch (error) {
          console.error("breadCrumb error", 789, error);
          return false;
        }
      }
      return return1;
    };
    watchEffect(() => {
      console.log("watchEffect refresh cat bradcramb");
      cats.value = createTreeCat(props.cat_id);
    });
    return (_ctx, _push, _parent, _attrs) => {
      var _a;
      const _component_NuxtLink = __nuxt_component_0$1;
      _push(`<div${ssrRenderAttrs(mergeProps({ class: "container mb-2" }, _attrs))}><div class="row"><div class="col-12"> breadcrumbComponent: <br> CatsAr: ${ssrInterpolate((_a = "CatsAr" in _ctx ? _ctx.CatsAr : unref(CatsAr)) != null ? _a : "x")}</div></div><div class="row">`);
      {
        _push(`<!---->`);
      }
      _push(`<div class="col-12"><nav aria-label="breadcrumb"><ol class="breadcrumb"><!--[-->`);
      ssrRenderList(unref(cats), (c) => {
        _push(`<li class="breadcrumb-item">`);
        _push(ssrRenderComponent(_component_NuxtLink, {
          to: "/cat/" + c.id
        }, {
          default: withCtx((_, _push2, _parent2, _scopeId) => {
            var _a2, _b;
            if (_push2) {
              _push2(`${ssrInterpolate((_a2 = c.name) != null ? _a2 : "x")}`);
            } else {
              return [
                createTextVNode(toDisplayString((_b = c.name) != null ? _b : "x"), 1)
              ];
            }
          }),
          _: 2
        }, _parent));
        _push(`</li>`);
      });
      _push(`<!--]--></ol></nav></div></div></div>`);
    };
  }
};
const _sfc_setup$1 = _sfc_main$1.setup;
_sfc_main$1.setup = (props, ctx) => {
  const ssrContext = useSSRContext();
  (ssrContext.modules || (ssrContext.modules = /* @__PURE__ */ new Set())).add("components/breadcrumbComponent.vue");
  return _sfc_setup$1 ? _sfc_setup$1(props, ctx) : void 0;
};
const __nuxt_component_0 = _sfc_main$1;
const _sfc_main = {
  __name: "[id]",
  __ssrInlineRender: true,
  async setup(__props) {
    let __temp, __restore;
    const route = useRoute();
    const cat_id = route.params.id;
    const showListCats = ref({});
    showListCats.value = ([__temp, __restore] = withAsyncContext(() => loadCats()), __temp = await __temp, __restore(), __temp);
    return (_ctx, _push, _parent, _attrs) => {
      var _a, _b, _c;
      const _component_breadcrumb_component = __nuxt_component_0;
      _push(`<div${ssrRenderAttrs(_attrs)} data-v-7260c54a><div class="container mt-3" data-v-7260c54a><div class="row" data-v-7260c54a><div class="col-12" data-v-7260c54a><a href="#" data-v-7260c54a>\u0437\u0430\u0433\u0440\u0443\u0437\u0438\u0442\u044C \u0434\u0430\u043D\u043D\u044B\u0435</a></div><div class="col-12" data-v-7260c54a><br data-v-7260c54a><br data-v-7260c54a><div style="${ssrRenderStyle({ "max-height": "50px", "font-size": "10px", "font-family": "arial", "overflow": "auto" })}" data-v-7260c54a> CatsAr: ${ssrInterpolate((_a = "CatsAr" in _ctx ? _ctx.CatsAr : unref(CatsAr)) != null ? _a : "x")}</div><div style="${ssrRenderStyle({ "max-height": "50px", "font-size": "10px", "font-family": "arial", "overflow": "auto" })}" data-v-7260c54a> showListCats: ${ssrInterpolate((_b = unref(showListCats)) != null ? _b : "x")}</div><br data-v-7260c54a><br data-v-7260c54a></div></div><div class="row" data-v-7260c54a><div class="col-md-12" data-v-7260c54a>`);
      _push(ssrRenderComponent(_component_breadcrumb_component, {
        xlinks: "catNow",
        cat_id: (_c = unref(cat_id)) != null ? _c : ""
      }, null, _parent));
      _push(`</div></div></div>`);
      {
        _push(`<!---->`);
      }
      _push(`</div>`);
    };
  }
};
const _sfc_setup = _sfc_main.setup;
_sfc_main.setup = (props, ctx) => {
  const ssrContext = useSSRContext();
  (ssrContext.modules || (ssrContext.modules = /* @__PURE__ */ new Set())).add("pages/cat/[id].vue");
  return _sfc_setup ? _sfc_setup(props, ctx) : void 0;
};
const _id_ = /* @__PURE__ */ _export_sfc(_sfc_main, [["__scopeId", "data-v-7260c54a"]]);

export { _id_ as default };
//# sourceMappingURL=_id_-3f15be5c.mjs.map
