import { _ as __nuxt_component_0 } from './nuxt-link-691ee40a.mjs';
import { withCtx, createTextVNode, useSSRContext } from 'vue';
import { ssrRenderAttrs, ssrRenderComponent, ssrRenderSlot } from 'vue/server-renderer';
import 'ufo';
import '../server.mjs';
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
import 'ohash';
import 'unstorage';
import 'radix3';
import 'node:fs';
import 'node:url';
import 'pathe';

const _sfc_main = {
  __name: "default",
  __ssrInlineRender: true,
  setup(__props) {
    console.log("\u0441\u0442\u0430\u0440\u0442 default layout template");
    return (_ctx, _push, _parent, _attrs) => {
      const _component_NuxtLink = __nuxt_component_0;
      _push(`<div${ssrRenderAttrs(_attrs)}><nav class="navbar navbar-expand-lg bg-dark mb-4" data-bs-theme="dark"><div class="container">`);
      _push(ssrRenderComponent(_component_NuxtLink, {
        class: "navbar-brand",
        to: "/cat/0"
      }, {
        default: withCtx((_, _push2, _parent2, _scopeId) => {
          if (_push2) {
            _push2(`\u0411\u044372.\u0440\u0444`);
          } else {
            return [
              createTextVNode("\u0411\u044372.\u0440\u0444")
            ];
          }
        }),
        _: 1
      }, _parent));
      _push(`<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button><div class="collapse navbar-collapse" id="navbarSupportedContent">`);
      {
        _push(`<ul class="navbar-nav me-auto mb-2 mb-lg-0"><li class="nav-item">`);
        _push(ssrRenderComponent(_component_NuxtLink, {
          class: "nav-link active",
          "aria-current": "page",
          to: "/cat/0"
        }, {
          default: withCtx((_, _push2, _parent2, _scopeId) => {
            if (_push2) {
              _push2(`\u041A\u0430\u0442\u0430\u043B\u043E\u0433`);
            } else {
              return [
                createTextVNode("\u041A\u0430\u0442\u0430\u043B\u043E\u0433")
              ];
            }
          }),
          _: 1
        }, _parent));
        _push(`</li></ul>`);
      }
      _push(`<ul class="navbar-nav ms-auto mb-2 mb-lg-0" role="search"><a href="https://php-cat.com" target="_blank" class="btn btn-success">php-cat.com</a></ul></div></div></nav>`);
      ssrRenderSlot(_ctx.$slots, "default", {}, null, _push, _parent);
      _push(`</div>`);
    };
  }
};
const _sfc_setup = _sfc_main.setup;
_sfc_main.setup = (props, ctx) => {
  const ssrContext = useSSRContext();
  (ssrContext.modules || (ssrContext.modules = /* @__PURE__ */ new Set())).add("layouts/default.vue");
  return _sfc_setup ? _sfc_setup(props, ctx) : void 0;
};

export { _sfc_main as default };
//# sourceMappingURL=default-eb9624e1.mjs.map
