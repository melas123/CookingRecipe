@cooking.service 'UploaderImage', ( FileUploader ) ->
  @uploader_image = ->
    #upload Image
    csrf_token =         document.querySelector('meta[name="csrf-token"]').getAttribute('content');
    uploader   =         new FileUploader(
      url:               '/image',
      alias:             'avatar',
      headers:           { 'X-CSRF-TOKEN': csrf_token,'request': 'application/json' },
      withCredentials:   true )
    #FILTERS for the images
    uploader.filters.push
      name: 'imageFilter'
      fn: (item, options) ->
        type = '|' + item.type.slice(item.type.lastIndexOf('/') + 1) + '|'
        '|jpg|png|jpeg|bmp|gif|'.indexOf(type) != -1
    return uploader

  return