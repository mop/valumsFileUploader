<?php if(!$this->doFiles): ?>     
    <h3><?php echo $GLOBALS['TL_LANG']['UPL']['be_upload_file']['0']; ?></h3>
<?php endif; ?>
<div class="backend" id="file-uploader">       
    <noscript>          
        <p><?php echo sprintf($GLOBALS['TL_LANG']['ERR']['val_be_noscript'], $this->noJsBeLink); ?></p>
    </noscript>
</div>

<script type="text/javascript">
    /* <![CDATA[ */
	
    function createUploader(vfu){
        var uploader = new qq.FileUploader({            
            // Uploader id
            element: document.getElementById('<?php echo $this->uploaderId; ?>'),
            
            // Path to server-side upload script
            action: '<?php echo $this->action; ?>',            
            
            // Get params for request
            params: <?php echo $this->params; ?>,

            // Allowed file extensions
            allowedExtensions: [<?php echo $this->objHelper->getStrExt($this->extensions); ?>],
            
            // Debug mode to show requests console
            debug: <?php echo ($this->debug) ? "true" : "false"; ?>,
            
            // Size limit
            sizeLimit: <?php echo ($this->maxFileSize) ? $this->maxFileSize : '""'; ?>,
            
            // Template wrapper for all items
            template: '<div class="qq-uploader">' + 
                '<div class="qq-upload-drop-area"><span><?php echo (strlen($this->dropTextLabel) != 0) ? $this->dropTextLabel : $GLOBALS['TL_LANG']['UPL'][$this->pos . '_upload_drop_area']; ?><\/span><\/div>' +
                '<div class="qq-upload-button"><?php echo (strlen($this->dropButtonLabel) != 0) ? $this->dropButtonLabel :  $GLOBALS['TL_LANG']['UPL'][$this->pos . '_upload_button']; ?><\/div>' +
                '<ul class="qq-upload-list"><\/ul>' + 
                '<\/div>',            
            
            // Template for one item in file list
            fileTemplate: '<li>' +
                <?php if($this->allowDelete) echo "'<a class=\"qq-upload-delete\" href=\"#\" onclick=\"return false;\"><\/a>' +"; ?>
                '<span class="qq-upload-file"><\/span>' +
                '<span class="qq-upload-spinner"><\/span>' +
                '<span class="qq-upload-size"><\/span>' +
                '<a class="qq-upload-cancel" href="#"><?php echo $GLOBALS['TL_LANG']['UPL']['upload_cancel']; ?><\/a>' +
                '<span class="qq-upload-text"><?php echo $GLOBALS['TL_LANG']['UPL']['upload_failed_text']; ?><\/span>' +
                '<\/li>',

            // Error messages
            messages: {
                typeError: <?php echo $GLOBALS['TL_LANG']['ERR']['val_type_error']; ?>,
                sizeError: <?php echo $GLOBALS['TL_LANG']['ERR']['val_size_error']; ?>,
                minSizeError: <?php echo $GLOBALS['TL_LANG']['ERR']['val_min_size_error']; ?>,
                emptyError: <?php echo $GLOBALS['TL_LANG']['ERR']['val_empty_error']; ?>,
                onLeave: <?php echo $GLOBALS['TL_LANG']['ERR']['val_on_leave']; ?>          
            },

            /**
             * Run valumsFileUploader class on complete
             */
            onComplete: function(id, fileName, responseJSON){
                vfu.setId(id);
                vfu.setfileName(fileName);
                vfu.setResponseJSON(responseJSON);
                
                vfu.run(id, fileName, responseJSON);
            }
        });
    }
            
    window.addEvent('domready', function(){
        // Create valumsFileUploader object and give them current params
        var vfu = new ValumsFileUploader({
            'action' : '<?php echo $this->action; ?>',
            'actionParam' : '<?php echo $this->actionParam; ?>',
            'fflId' : '<?php echo $this->strId; ?>',
            'fflIdName' : '<?php echo $this->uploaderId; ?>',            
            'detailsFailureMessage' : <?php echo (($this->detailsFailureMessage) ? 'true' : 'false'); ?>,
            'allowDelete' : <?php echo ($this->allowDelete) ? 'true' : 'false'; ?>
                    }); 

        // Create ajax-uploader
        createUploader(vfu);
    });
	
    /* ]]> */
</script>

<?php if(!$this->doFiles && $this->description == NULL): ?>
    <p class="tl_help tl_tip"><?php echo $GLOBALS['TL_LANG']['UPL']['be_upload_file']['1']; ?></p>
<?php endif; ?>