<?php if (!$this->tableless): ?>
    <tr class="<?php echo $this->rowClass; ?>">
        <td class="col_0 col_first"><?php echo $this->generateLabel(); ?></td>
        <td class="col_1 col_last"><?php echo $this->generateWithError(); ?></td>
    </tr>
<?php else: ?>
    <?php echo $this->generateLabel(); ?> 
    <?php echo $this->generateWithError(); ?><br />
<?php endif; ?>
    
<script type="text/javascript">
    /* <![CDATA[ */
    function createUploader(){  
        var uploader = new qq.FileUploader({
            element: document.getElementById('file-uploader-<?php echo $this->strId; ?>'),
            // path to server-side upload script
            action: '<?php echo $this->action; ?>',
            // additional data to send, name-value pairs
            params: <?php echo $this->params; ?>,
            // validation    
            // ex. ['jpg', 'jpeg', 'png', 'gif'] or []
            allowedExtensions: [<?php echo $this->objHelper->getStrExt($this->extensions); ?>],        
            // set to true to output server response to console
            debug: <?php echo ($this->debug) ? "'true'" : "'false'"; ?>,
            sizeLimit: <?php echo ($this->val_max_file_length) ? $this->val_max_file_length : '""'; ?>,
            // Template wrapper for all items
            template: '<div class="qq-uploader">' + 
                '<div class="qq-upload-drop-area"><span><?php echo (strlen($this->val_drop_text) != 0) ? $this->val_drop_text : $GLOBALS['TL_LANG']['UPL']['fe_upload_drop_area']; ?><\/span><\/div>' +
                '<div class="qq-upload-button"><?php echo (strlen($this->val_init_text) != 0) ? $this->val_init_text :  $GLOBALS['TL_LANG']['UPL']['fe_upload_button']; ?><\/div>' +
                '<ul class="qq-upload-list"><\/ul>' + 
                '<\/div>',
            // Template for one item in file list
            fileTemplate: '<li>' +
                '<span class="qq-upload-file"><\/span>' +
                '<span class="qq-upload-spinner"><\/span>' +
                '<span class="qq-upload-size"><\/span>' +
                '<a class="qq-upload-cancel" href="#"><?php echo $GLOBALS['TL_LANG']['UPL']['upload_cancel']; ?><\/a>' +
                '<span class="qq-upload-failed-text"><?php echo $GLOBALS['TL_LANG']['UPL']['upload_failed_text']; ?><\/span>' +
                '<\/li>',
            // Error messages
            messages: {
                typeError: <?php echo $GLOBALS['TL_LANG']['ERR']['val_type_error']; ?>,
                sizeError: <?php echo $GLOBALS['TL_LANG']['ERR']['val_size_error']; ?>,
                minSizeError: <?php echo $GLOBALS['TL_LANG']['ERR']['val_min_size_error']; ?>,
                emptyError: <?php echo $GLOBALS['TL_LANG']['ERR']['val_empty_error']; ?>,
                onLeave: <?php echo $GLOBALS['TL_LANG']['ERR']['val_on_leave']; ?>          
            },
            
            onComplete: function(id, fileName, responseJSON){
                
                <?php if($this->detailsFailureMessage): ?>
                if(!responseJSON.success)
                {
                    var qqUploadListChilds = $$('#file-uploader .qq-upload-list').getChildren();
                    var elem = qqUploadListChilds[0][id].getChildren('.qq-upload-failed-text')[0];
                    elem.set({html:responseJSON.reasonText}); 
                }
                <?php endif; ?>                
                
            }
        });        
    }
    window.onload = createUploader;
    /* ]]> */
</script>