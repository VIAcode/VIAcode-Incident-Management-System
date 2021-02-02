class DelegateModal {

	static delegate(id){
		$("a[rel='vims-modal:close']")[0].click();
		let url = GetOrchestratorUrl() + '/vo-api/azuredevops';
		$.post( url, { vimsid: id }, function(data){
				
		});
	}
}
  

  function SendDelegation(){
	  let ticketId = document.URL.substr(document.URL.lastIndexOf('/') + 1);
	  $.get(GetOrchestratorUrl() + '/vo-api/VimsOrganizationAzureDevOpsSettings', { vimsid: ticketId }, function(resp){
        let okBtn = $('<input class="btn btn--success align-right" type="button" value="Ok"/>');
	okBtn.click(Delegate);
	let modalRightFooter = $('<div class="modal-rightFooter"></div>');
	modalRightFooter.append(okBtn);
	let modalFooter = $('<div class="modal-footer"></div>');
	modalFooter.append(`<div class="modal-leftFooter">
                            <a rel="vims-modal:close" class="btn btn--subtle btn--text align-left">Cancel & Go Back</a>
                          </div>`);
        modalFooter.append(modalRightFooter);
        let modalContent = $('<div class="modal-content"></div>');
	modalContent.append(`<div class="modal-header">
                      <a rel="vims-modal:close" class="modal-close"><svg class="icon icon-diagonal-cross "><use xlink:href="assets/images/icons.svg#icon-diagonal-cross"></use></svg></a>
                      <h1 class="modal-title">Delegate</h1>
                    </div>
                      <div class="modal-body">
                        The incident will be linked to a Backlog Item (new or existing) at the connected Azure DevOps project. If the exisitng Backlog Item is closed or removed it will be reopened.
                        <br />
                        Backlog Item details:
                        <ul>
                            <li>Backlog Item Name: ` + resp.backlogItemName + `</li>
                            <li>Organization: ` + resp.organization + `</li>
                            <li>Project: ` + resp.project + `</li>
                            <li>Area: ` + resp.area + `</li>
                        </ul>
                      </div>`);
        modalContent.append(modalFooter);
        let vimsDelegateModal = $('<div id="vimsDelegateModal" class="vims-hidden modal-dialog"></div>');
	vimsDelegateModal.append(modalContent);
        $('#vims').append(vimsDelegateModal);
		vimsDelegateModal.vims_modal({
            showClose: false,
            modalClass: "vims-hidden",
            blockerClass: "vims-blocker-light"            
          });
        vimsDelegateModal.on($.vims_modal.AFTER_CLOSE, function(event, modal){
			  vimsDelegateModal.remove();
		  });
	  }).fail(function(data) {
        if(![400, 403, 404, 408, 500, 502, 503].includes(data.status)){
			new AlertModal().show('The Azure DevOps Connector API cannot be reached. Please check if Azure DevOps connector is deployed and configured <link to Azure DevOps AMP>');	
            return;
        }
		new AlertModal().show(data.responseText);
	  });
  }

  function Delegate(){
	    let ticketId = document.URL.substr(document.URL.lastIndexOf('/') + 1);
	    DelegateModal.delegate(ticketId);
  }

  function GetOrchestratorUrl(){
    let location = window.location.origin;
    return location.split('.')[0] + '-azdevops' + location.substr(location.indexOf('.', 0));
  }
  
  class AlertModal {	  
	  show(text){
		  $('#vims').append(`<div id="vims-alertModal" class="modal-dialog vims-hidden">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <a rel="vims-modal:close" class="modal-close"><svg class="icon icon-diagonal-cross "><use xlink:href="assets/images/icons.svg#icon-diagonal-cross"></use></svg></a>
                                        <h1 class="modal-title">Warning</h1>
                                    </div>
                                    <div id="vims-alertModal-text" class="modal-body"></div>
                                    <div class="modal-footer"></div>
                                </div>
                            </div>`);
		  $('#vims-alertModal-text').html(text);
		  $('#vims-alertModal').vims_modal({
            showClose: false,
            modalClass: "",
            blockerClass: "vims-blocker-light"            
          });		
		  $('#vims-alertModal').on($.vims_modal.AFTER_CLOSE, function(event, modal){
			  $('#vims-alertModal').remove();
		  });
	  }
  }
