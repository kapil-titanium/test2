/*
 * jQuery File Upload Plugin JS Example 6.5.1
 * https://github.com/blueimp/jQuery-File-Upload
 *
 * Copyright 2010, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * http://www.opensource.org/licenses/MIT
 */

/*jslint nomen: true, unparam: true, regexp: true */
/*global $, window, document */

$(function () {

    function update(coords)
    {
      $('#picture_crop_x').val(coords.x)
      $('#picture_crop_y').val(coords.y)
      $('#picture_crop_w').val(coords.w)
      $('#picture_crop_h').val(coords.h)
    };

   $('#cropbox').Jcrop({
      boxWidth: 770,
      boxHeight: 433,
      onSelect: update,
      onChange: update
    });
    
    $('#profilepic_cropbox').Jcrop({
      boxWidth: 770,
      boxHeight: 433,
      // minSize: [110, 110],
      // maxSize: [110, 110],
      aspectRatio: 1,
      setSelect: [0, 0, 110, 110],
      onSelect: update,
      onChange: update
    });
    
    $('#coverpic_cropbox').Jcrop({
      boxWidth: 770,
      boxHeight: 433,
      // minSize: [970, 280],
      // maxSize: [970, 280],
      aspectRatio: 97/28,
      setSelect: [00, 00, 588, 168],
      onSelect: update,
      onChange: update
    });


    'use strict';

    // Initialize the jQuery File Upload widget:
    $('#fileupload').fileupload({
      autoUpload: true,
      uploadTemplate: function (o) {
        var rows = $();
        $.each(o.files, function (index, file) {
          console.log(file);
            var row = $('<li class="span3">' +
                '<div class="thumbnail">' +
                  '<div class="preview" style="text-align: center;"></div>' +
                  '<div class="progress progress-success progress-striped active">' +
                    '<div class="bar" style="width:0%;"></div>' +
                  '</div>' +
                '</div>');
            rows = rows.add(row);
        });
        return rows;
    },

    completed: function(e, data) {
      console.log(data.result[0].url);
      $('a[href^="' + data.result[0].url + '"]').slimbox();
    },
    downloadTemplate: function (o) {
        var rows = $();
        $.each(o.files, function (index, file) {
            var row = $('<li class="span3" id="picture_' + file.picture_id + '">' +
                (file.error ? '<div class="name"></div>' +
                    '<div class="size"></div><div class="error" ></div>' :
                    (
                      '<div class="thumbnail">' +
                        '<a href="' + file.url +'" rel="lightbox-pictures" class="picture_' + file.id + '" title="' + file.name + '">' +
                          '<img src="" alt="">') +
                        '</a>' +
                        '<div class="caption">' +
                          '<p style="text-align: center;">' +
                            // '<a href="" class="btn btn-mini btn-show" style="margin-right: 4px;">' +
                              // '<i class="icon-edit "></i>' +
                              // 'Edit' +
                            // '</a>' +
                            // '<a class="btn btn-mini btn_font" id="cov_pic" confirm="Вы уверены?" href="" >' +
                              // 'Set as Cover Picture' +
                            // '</a>' +
                            '<a class="btn btn-mini btn_font" id="prof_pic" confirm="Вы уверены?" href="" >' +
                              'Set as Profile Picture' +
                            '</a>' +
                            '<a class="btn btn-mini btn-delete" confirm="Вы уверены?" data-remote=true data-method="delete" href="" >' +
                              '<i class="icon-trash"></i>' +
                              'Delete' +
                            '</a>' +
                          '</p>' +
                        '</div>' +
                      '</div>'
                      )
                  );

            if (file.error) {
                row.find('.name').text(file.name);
                row.find('.error').text('Error: ' +
                    ('File format not supported OR ' + locale.fileupload.errors[file.error]) || ('File format not supported OR ' + file.error)
                );
            } else {
                if (file.thumbnail_url) {
                    row.find('img').prop('src', file.thumbnail_url);
                }
                // row.find('#cov_pic')
                    // .attr('href', '/kitchens/' + $("#kitchenID").val() + '/galleries/' + $("#galleryID").val() + '/pictures/' + file.picture_id + '/edit?image_flag_id=18');
                row.find('#prof_pic')
                    .attr('href', '/kitchens/' + $("#kitchenID").val() + '/galleries/' + $("#galleryID").val() + '/pictures/' + file.picture_id + '/edit?image_flag_id=53');
                row.find('.btn-delete')
                    .attr('href', '/kitchens/' + $("#kitchenID").val() + '/galleries/' + $("#galleryID").val() + '/pictures/' + file.picture_id);
                row.find('.btn-show')
                    .attr('href', '/kitchens/' + $("#kitchenID").val() + '/galleries/' + $("#galleryID").val() + '/pictures/' + file.picture_id + '/edit');
            	
            	var url = '/kitchens/' + $("#kitchenID").val() + '/galleries/' + $("#galleryID").val();
            	$(location).attr('href', url);
            }
            rows = rows.add(row);
        });
        return rows;
    }

  });
  
  
  $('#fileupload_profile_pic').fileupload({
      autoUpload: true,
      uploadTemplate: function (o) {
        var rows = $();
        $.each(o.files, function (index, file) {
          console.log(file);
            var row = $('<li class="span3">' +
                '<div class="thumbnail">' +
                  '<div class="preview" style="text-align: center;"></div>' +
                  '<div class="progress progress-success progress-striped active">' +
                    '<div class="bar" style="width:0%;"></div>' +
                  '</div>' +
                '</div>');
            rows = rows.add(row);
        });
        return rows;
    },

    completed: function(e, data) {
      console.log(data.result[0].url);
      $('a[href^="' + data.result[0].url + '"]').slimbox();
    },
    downloadTemplate: function (o) {
        var rows = $();
        $.each(o.files, function (index, file) {
            var row = $('<li class="span3" id="picture_' + file.picture_id + '">' +
                (file.error ? '<div class="name"></div>' +
                    '<div class="size"></div><div class="error" ></div>' :
                    (
                      '<div class="thumbnail">' +
                        '<a href="' + file.url +'" rel="lightbox-pictures" class="picture_' + file.id + '" title="' + file.name + '">' +
                          '<img src="" alt="">') +
                        '</a>' +
                        '<div class="caption">' +
                          '<p style="text-align: center;">' +
                            // '<a href="" class="btn btn-mini btn-show" style="margin-right: 4px;">' +
                              // '<i class="icon-edit "></i>' +
                              // 'Edit' +
                            // '</a>' +
                            // '<a class="btn btn-mini btn_font" id="cov_pic" confirm="Вы уверены?" href="" >' +
                              // 'Set as Cover Picture' +
                            // '</a>' +
                            '<a class="btn btn-mini btn_font" id="prof_pic" confirm="Вы уверены?" href="" >' +
                              'Set as Profile Picture' +
                            '</a>' +
                            '<a class="btn btn-mini btn-delete" confirm="Вы уверены?" data-remote=true data-method="delete" href="" >' +
                              '<i class="icon-trash"></i>' +
                              'Delete' +
                            '</a>' +
                          '</p>' +
                        '</div>' +
                      '</div>'
                      )
                  );

            if (file.error) {
                row.find('.name').text(file.name);
                row.find('.error').text('Error: ' +
                    ('File format not supported OR ' + locale.fileupload.errors[file.error]) || ('File format not supported OR ' + file.error)
                );
            } else {
                if (file.thumbnail_url) {
                    row.find('img').prop('src', file.thumbnail_url);
                }
                // row.find('#cov_pic')
                    // .attr('href', '/kitchens/' + $("#kitchenID").val() + '/galleries/' + $("#galleryID").val() + '/pictures/' + file.picture_id + '/edit?image_flag_id=18');
                row.find('#prof_pic')
                    .attr('href', '/kitchens/' + $("#kitchenID").val() + '/galleries/' + $("#galleryID").val() + '/pictures/' + file.picture_id + '/edit?image_flag_id=53');
                row.find('.btn-delete')
                    .attr('href', '/kitchens/' + $("#kitchenID").val() + '/galleries/' + $("#galleryID").val() + '/pictures/' + file.picture_id);
                row.find('.btn-show')
                    .attr('href', '/kitchens/' + $("#kitchenID").val() + '/galleries/' + $("#galleryID").val() + '/pictures/' + file.picture_id + '/edit');
            	
            	var url = '/kitchens/' + $("#kitchenID").val() + '/galleries/' + $("#galleryID").val() + '/pictures/' + file.picture_id + '/edit?image_flag_id=53';
        		$(location).attr('href', url);
            }            
            rows = rows.add(row);
        });
        return rows;
    }

  });
  
  $('#fileupload_cover_pic').fileupload({
      autoUpload: true,
      uploadTemplate: function (o) {
        var rows = $();
        $.each(o.files, function (index, file) {
          console.log(file);
            var row = $('<li class="span3">' +
                '<div class="thumbnail">' +
                  '<div class="preview" style="text-align: center;"></div>' +
                  '<div class="progress progress-success progress-striped active">' +
                    '<div class="bar" style="width:0%;"></div>' +
                  '</div>' +
                '</div>');
            rows = rows.add(row);
        });
        return rows;
    },

    completed: function(e, data) {
      console.log(data.result[0].url);
      $('a[href^="' + data.result[0].url + '"]').slimbox();
    },
    downloadTemplate: function (o) {
        var rows = $();
        $.each(o.files, function (index, file) {
            var row = $('<li class="span3" id="picture_' + file.picture_id + '">' +
                (file.error ? '<div class="name"></div>' +
                    '<div class="size"></div><div class="error" ></div>' :
                    (
                      '<div class="thumbnail">' +
                        '<a href="' + file.url +'" rel="lightbox-pictures" class="picture_' + file.id + '" title="' + file.name + '">' +
                          '<img src="" alt="">') +
                        '</a>' + 
                        '<div class="caption">' +
                          '<p style="text-align: center;">' +
                            // '<a href="" class="btn btn-mini btn-show" style="margin-right: 4px;">' +
                              // '<i class="icon-edit "></i>' +
                              // 'Edit' +
                            // '</a>' +
                            // '<a class="btn btn-mini btn_font" id="cov_pic" confirm="Вы уверены?" href="" >' +
                              // 'Set as Cover Picture' +
                            // '</a>' +
                            '<a class="btn btn-mini btn_font" id="prof_pic" confirm="Вы уверены?" href="" >' +
                              'Set as Profile Picture' +
                            '</a>' +
                            '<a class="btn btn-mini btn-delete" confirm="Вы уверены?" data-remote=true data-method="delete" href="" >' +
                              '<i class="icon-trash"></i>' +
                              'Delete' +
                            '</a>' +
                          '</p>' +
                        '</div>' +
                      '</div>'
                      )
                  );

            if (file.error) {
                row.find('.name').text(file.name);
                row.find('.error').text('Error: ' +
                    ('File format not supported OR ' + locale.fileupload.errors[file.error]) || ('File format not supported OR ' + file.error)
                );
            } else {
                if (file.thumbnail_url) {
                    row.find('img').prop('src', file.thumbnail_url);
                }
                // row.find('#cov_pic')
                    // .attr('href', '/kitchens/' + $("#kitchenID").val() + '/galleries/' + $("#galleryID").val() + '/pictures/' + file.picture_id + '/edit?image_flag_id=18');
                row.find('#prof_pic')
                    .attr('href', '/kitchens/' + $("#kitchenID").val() + '/galleries/' + $("#galleryID").val() + '/pictures/' + file.picture_id + '/edit?image_flag_id=53');
                row.find('.btn-delete')
                    .attr('href', '/kitchens/' + $("#kitchenID").val() + '/galleries/' + $("#galleryID").val() + '/pictures/' + file.picture_id);
                row.find('.btn-show')
                    .attr('href', '/kitchens/' + $("#kitchenID").val() + '/galleries/' + $("#galleryID").val() + '/pictures/' + file.picture_id + '/edit');
            	
            	var url = '/kitchens/' + $("#kitchenID").val() + '/galleries/' + $("#galleryID").val() + '/pictures/' + file.picture_id + '/edit?image_flag_id=18';
        		$(location).attr('href', url);
            }            
            rows = rows.add(row);
        });
        return rows;
    }

  });
  
});
