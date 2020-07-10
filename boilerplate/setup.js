;(function (Zdog) {
  const ctorMap = {
    1: 'Rect',
    2: 'RoundedRect',
    3: 'Ellipse',
    4: 'Polygon',
    5: 'Shape',
    6: 'Hemisphere',
    7: 'Cone',
    8: 'Cylinder',
    9: 'Box',
  }

  // should be synced with `type Msg` in boilerplate/Zdog/Update.elm
  const msgMap = {
    0: 'set-root',
    1: 'update-graph',
  }

  function createShape(a, params) {
    const Ctor = ctorMap[params.tag]
    if (!Ctor) {
      throw new TypeError(`No constructor for tag: ${params.tag}!`)
    }

    return new Zdog[Ctor]({
      addTo: a,
      ...params,
    })
  }

  class ElmZdogElement extends HTMLElement {
    static get observedAttributes() {
      return ['operation', 'type']
    }

    constructor() {
      super()

      const shadow = this.attachShadow({ mode: 'open' })
      const canvas = document.createElement('canvas')

      /**
       * Consider this as normal HTML canvas, we can manipulate anything from
       * normal virtual DOM operation from inside Elm, e.g. set attributes and events.
       *
       * TODO: support SVG
       */
      shadow.appendChild(canvas)

      // TODO: keep track on graph updates
      this.anchorMap = new Map()
      this.lastAnchorId = 0
      this.root = null
      this.canvas = canvas

      // My plan is to share `this.model` and `this.config` between Elm and custom elements.
      // Although update is always done by Elm, this might be too complicated.
    }

    connectedCallback() {
      const canvas = this.canvas
      canvas.setAttribute('width', this.getAttribute('width'))
      canvas.setAttribute('height', this.getAttribute('height'))
    }

    attributeChangedCallback(name, oldValue, newValue) {
      if (oldValue !== newValue) {
        switch (name) {
          case 'operation':
            const msg = msgMap[newValue]
            if (msg === 'set-root') {
              this.setRoot()
            }
            break
          default:
            break
        }
      }
    }

    setRoot() {
      if (!this.config || !this.model) {
        // Something goes wrong in Elm
        return
      }
      // TODO: support Anchor as well as Illustration
      const { model, canvas, config } = this
      const illo = new Zdog.Illustration({
        element: canvas,
        dragRotate: !!(config && config.dragRotate),
      })

      for (const params of model) {
        createShape(illo, params)
      }

      if (config && (config.useAnimation || config.dragRotate)) {
        function animate() {
          illo.updateRenderGraph()
          requestAnimationFrame(animate)
        }
        animate()
      } else {
        illo.updateRenderGraph()
      }

      this.root = illo
      this.trackAnchor(this.lastAnchorId++, this.root)
    }

    updateGraph() {
      // make sure we have params updated
      // TODO: patching?
      if (!this.root || !this.model) return
    }

    trackAnchor(id, anchor) {
      const oldAnchor = this.anchorMap.get(id)
      if (oldAnchor != null) {
        // do some cleanup
      }
      this.anchorMap.set(id, anchor)
    }
  }

  customElements.define('elm-zdog-element', ElmZdogElement)
})(window.Zdog)
