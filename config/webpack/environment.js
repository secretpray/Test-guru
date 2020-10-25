const { environment } = require('@rails/webpacker')
const erb = require('./loaders/erb')

const webpack = require('webpack')
environment.plugins.append('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: ['popper.js', 'default']
  })
)

environment.loaders.prepend('erb', erb)
module.exports = environment
