# encoding: utf-8
require 'pony'

def valid_email?(email)
  if email =~ /^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/
    #domain = email.match(/\@(.+)/)[1]
    #Resolv::DNS.open do |dns|
        #@mx = dns.getresources(domain, Resolv::DNS::Resource::IN::MX)
    #end
    #@mx.size > 0 ? true : false
    true
  else
    false
  end
end

def valid_captcha? answer
  open("http://captchator.com/captcha/check_answer/#{@captcha_id}/#{answer}").read.to_i.nonzero? rescue false
end

def valid_url? url
  return true if url == "http://"
  !(url =~ /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix).nil?
end

def given? field
  !field.empty?
end

def validate params
  errors = {}
  
  [:name, :email, :content].each{|key| params[key] = (params[key] || "").strip }
  
  errors[:name]    = "名字不能为空" unless given? params[:name]
  
  if given? params[:email]
    errors[:email]   = "请输入正确的Email" unless valid_email? params[:email]
  else
    errors[:email]   = "Email不能为空"
  end
  #errors[:website] = "Please enter a valid web address" unless valid_url? params[:website]
  errors[:content] = "内容不能为空" unless given? params[:message]
  
  #if given? params[:captcha]
    #errors[:captcha] = "The code you've entered is not valid" unless valid_captcha? params[:captcha]
  #else
    #errors[:captcha] = "Please enter the code as shown in the picture"
  #end
  
  errors
end

def send_email params, ip_address
  email_template = <<-EOS
  时间:          {{ when }}  
  IP 地址:    {{ ip_address }}
  
  名字:     {{ name }}
  Email:         {{ email }}
  产品:       {{ website }}

  内容:       
  
  {{  content }}

  EOS
  
  body = Liquid::Template.parse(email_template).render  "name"       => params[:name], 
                                                        "email"      => params[:email], 
                                                        "company"    => params[:company], 
                                                        "product"    => params[:product], 
                                                        "content"    => params[:content], 
                                                        "when"       => Time.now.strftime("%b %e, %Y %H:%M:%S %Z"), 
                                                        "ip_address" => ip_address
  
  Pony.mail(:to => "gxbsst@gmail.com", :from => params[:email], :subject => "A comment from #{params[:name]}", :body => body)
end
