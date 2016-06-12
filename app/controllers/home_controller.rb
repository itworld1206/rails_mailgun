require 'mailgun'

class HomeController < ApplicationController
  def index
  end
  
  def write 
    # Create
    new_post         = Post.new
    new_post.title   = params[:title]
    new_post.content = params[:content]
    new_post.email   = params[:email]
    new_post.save
    
    # 이메일 보내는 기능
    # First, instantiate the Mailgun Client with your API key
    mg_client = Mailgun::Client.new 'key-47c60e4981cf2d30ee24330e1a946efb'
    
    # Define your message parameters
    message_params =  { from: 'master@likelion.net',
                        to:   'justinkim0310@hotmail.com',
                        subject: new_post.title,
                        text:    new_post.content
                      }
    
    # Send your message through the client
    mg_client.send_message 'sandboxd5c50625a8a248b280b3dbe28e296cb4.mailgun.org', message_params
        
    redirect_to '/list'
  end
  
  def list  # Read
    @every_post = Post.all.order('id desc')
  end
  
  def update_view
    @one_post = Post.find(params[:post_id])
  end
  
  def update
    one_post         = Post.find(params[:post_id])
    one_post.title   = params[:title]
    one_post.content = params[:content]
    one_post.email   = params[:email]
    one_post.save
    
    redirect_to '/list'
  end
  
  def destroy # Destroy
    @one_post = Post.find(params[:post_id])
    @one_post.destroy
    
    redirect_to '/list'
  end
end
