# Copyright (C) 2012-2016 Zammad Foundation, http://zammad-foundation.org/
require 'net/http'

class Observer::Ticket::Article::CommunicateAzureDevOps < ActiveRecord::Observer
  observe 'ticket::_article'

  def after_create(record)
    ticket = record.ticket
    if ticket.external_ticket_id
      user = User.find_by(id: record.created_by_id)    
      if user.login != 'azdevops'
        host = ENV["HOST_NAME"]
        org = ticket.organization
        Net::HTTP.post_form URI('https://' + host.split(".").first + '-azdevops' + host[host.index('.')..-1] + '/vo-api/ArticleAdded'), { "workitemid" => ticket.external_ticket_id, "body" => record.body, "organization" => org.azuredevops_organization, "project" => org.azuredevops_project, "area" => org.azuredevops_area, "token" => org.azuredevops_token }
      end
    end
  end

end
