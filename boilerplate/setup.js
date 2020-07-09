(function(Zdog) {

  const ctorMap = {
    1: 'Rect',
    2: 'RoundedRect',
    3: 'Ellipse',
    4: 'Polygon',
    5: 'Shape',
    6: 'Hemisphere',
    7: 'Cone',
    8: 'Cylinder',
    9: 'Box'
  }

  function createShape(a, params) {
    const Ctor = ctorMap[params.tag]
    if (!Ctor) {
      throw new TypeError(`No constructor for tag: ${params.tag}!`)
    }

    return new Zdog[Ctor]({
      addTo: a,
      ...params
    })
  }

  function install(app) {
    let illo, wrapper
    ;

    function onMount([config, model]) {
      if (!illo) {
        const uid = 'elm-zdog-' + Math.random().toString().replace(/\W/g, '-')

        wrapper = document.createElement('canvas')
        wrapper.setAttribute('id', uid)
        wrapper.setAttribute('width', config.width)
        wrapper.setAttribute('height', config.height)
        document.body.appendChild(wrapper)
        ;

        illo = new Zdog.Illustration({
          element: wrapper,
          dragRotate: !!config.dragRotate
        })

        for (const params of model) {
          createShape(illo, params)
        }

        if (config.useAnimation || config.dragRotate) {
          function animate() {
            illo.updateRenderGraph()
            requestAnimationFrame(animate)
          }
          animate()
        } else {
          illo.updateRenderGraph()
        }
      }
    }

    app.ports.requireIllo.subscribe(onMount)
  }

  // Hello, Zdog!
  Zdog.installToElm = install
})(window.Zdog)