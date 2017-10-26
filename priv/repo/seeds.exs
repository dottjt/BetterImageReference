# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Bdr.Repo.insert!(%Bdr.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Bdr.Repo

alias Bdr.Account.Email
alias Bdr.Account.User 

alias Bdr.ApiResources
alias Bdr.ApiResources.Collection

alias Bdr.Collection.Book
alias Bdr.Collection.Tutorial
alias Bdr.Collection.Tag

alias Bdr.Image
alias Bdr.Image.Scribble
alias Bdr.Image.Tag

alias Bdr.Blog
alias Bdr.Photo


# {:ok, user_id} = Ecto.UUID.load(Ecto.UUID.bingenerate())

# %Plug.Upload{
#     content_type: "image/png",
#     filename: "selfie.png",
#     path: "/var/folders/q0/dg42x390000gp/T//plug-1434/multipart-765369-5"}
# }


Repo.insert!(%User{
    # id: user_id,
    name: "julius-reade",
    display_name: "Julius Reade",
    avatar: "https://s-media-cache-ak0.pinimg.com/did-it/750x/90/89/45/908945db5f25216e64c0b466b214162b.jpg",
    email: "julius_dott@hotmail.com",
    password: "hellothere",
    password_hash: "hellothere",
    is_admin: true,
    tier: "god",
    auth_provider: "no-idea",
    image_comments: [],
    blog_comments: [],
    image_scribbles: [],
    blog: [
        %ApiResources.Blog{
            name: "how-to-become-a-better-artist",
            display_name: "Dog",
            excerpt: "There is just a little problem with people who have the better saint of literature",
            featured_image: "https://s-media-cache-ak0.pinimg.com/did-it/750x/90/89/45/908945db5f25216e64c0b466b214162b.jpg",
            blog_comments: [
                %Blog.Comment{
                    # user_id: "addbfda4-dda5-4809-87bb-3fbda1d6aef1",
                    text: "this is a comment for this blog. So if you have a problem with that, then that's a problem, ain't it ;)"
                }
            ]
        },
        %ApiResources.Blog{
            name: "we-are-the-champions",
            display_name: "Corky The Porky",
            excerpt: "There is just a little problem with people who have the better saint of literature",
            featured_image: "https://s-media-cache-ak0.pinimg.com/did-it/750x/90/89/45/908945db5f25216e64c0b466b214162b.jpg",
            blog_comments: [
                %Blog.Comment{
                    text: "happy problems are a thing they are, they are, ain't it ;)"
                }
            ]
        }        
    ],
    collections: [
        %Collection{
            name: "figure-drawing",
            display_name: "Figure Drawing",
            external_url: "",
            featured_image: "https://s-media-cache-ak0.pinimg.com/did-it/750x/90/89/45/908945db5f25216e64c0b466b214162b.jpg",
            collection_books: [
                %Book{
                    name: "this-is-the-book-name",
                    display_name: "This is the Book Name",
                    url: "http://phoenixframework.org/blog/seeding-data"
                },
                %Book{
                    name: "how-to-win-friends-and-all-that-jazz",
                    display_name: "How to win books and all that Jazzzzz",
                    url: "http://phoenixframework.org/blog/seeding-data"
                }                
            ],
            collection_tutorials: [
                %Tutorial{
                    name: "this-is-the-tutorial-name",
                    display_name: "This is the Tutorial Name",
                    url: "http://phoenixframework.org/blog/seeding-data"
                },
                %Tutorial{
                    name: "how-to-win-tutorials-and-all-that-jazz",
                    display_name: "How to win tutorials and all that Jazzzzz",
                    url: "http://phoenixframework.org/blog/seeding-data"
                }                                
            ],
            collection_tags: [],           
            images: [
                %ApiResources.Image{
                    name: "caity",
                    display_name: "Caitlin Face",
                    description: "a really good photo of something OR rather",
                    image_url: "https://s-media-cache-ak0.pinimg.com/did-it/750x/90/89/45/908945db5f25216e64c0b466b214162b.jpg",
                    times_drawn: 2,
                    # photo: %Plug.Upload{content_type: "", filename: "file.jpg", path: "http://example.com/file.jpg"},
                    image_tags: [],
                    image_comments: [
                        %Image.Comment{
                            text: "this is a really good picture, I really like how it handles itself"
                        },
                        %Image.Comment{
                            text: "super awesome, yeah boy!"
                        },
                    ],
                    image_scribbles: [
                        %Scribble{
                            name: "you-know",
                            display_name: "Not Really TBH",
                            description: "This is a scribble of an image",
                            data: ""
                        },
                        %Scribble{
                            name: "yep-yolo",
                            display_name: "I like the hands",
                            description: "The hands and ears are hearing",                            
                            data: ""                            
                        },                                
                        %Scribble{
                            name: "how-to-win-tutorials-and-all-that-jazz",
                            display_name: "How to win tutorials and all that Jazzzzz",
                            description: "we all know that you're going to be sorry",                                                        
                            data: ""                            
                        }                                                                  
                    ],

                },
                %ApiResources.Image{
                    name: "happily-there-you-know",
                    display_name: "Yes, We Know That Youre Happily There",
                    description: "take a compliment bby",                    
                    image_url: "https://s-media-cache-ak0.pinimg.com/did-it/750x/90/89/45/908945db5f25216e64c0b466b214162b.jpg",
                    times_drawn: 300,
                    # photo: %Plug.Upload{filename: "file.jpg", path: "http://example.com/file.jpg"},
                    image_tags: [],
                    image_scribbles: [],                    
                    image_comments: [
                        %Image.Comment{
                            text: "cool story bro"
                        },
                        %Image.Comment{
                            text: "really nice setup you have :)"
                        },
                    ]
                },
                %ApiResources.Image{
                    name: "zzzzzzz-there-you-know",
                    display_name: "zzzzzzzzsss Happily There",
                    description: "fffftrt",                    
                    image_url: "https://s-media-cache-ak0.pinimg.com/did-it/750x/90/89/45/908945db5f25216e64c0b466b214162b.jpg",
                    times_drawn: 900,                    
                    image_tags: [],
                    image_scribbles: [],                    
                    image_comments: [
                        %Image.Comment{
                            text: "cool story bro"
                        },
                        %Image.Comment{
                            text: "really nice setup you have :)"
                        },
                    ]
                }              
            ]
        },
        %Collection{
            name: "cat",
            display_name: "Cat",
            external_url: "",            
            featured_image: "https://s-media-cache-ak0.pinimg.com/did-it/750x/90/89/45/908945db5f25216e64c0b466b214162b.jpg",
            collection_books: [],            
            collection_tutorials: [],
            collection_tags: [],
            images: []
        },        
        %Collection{
            name: "dog",
            display_name: "Dog",
            external_url: "",            
            featured_image: "https://s-media-cache-ak0.pinimg.com/did-it/750x/90/89/45/908945db5f25216e64c0b466b214162b.jpg",
            collection_books: [],            
            collection_tutorials: [],
            collection_tags: [],
            images: []            
        },        
        %Collection{
            name: "human-face",
            display_name: "Human Face",
            external_url: "",            
            featured_image: "https://s-media-cache-ak0.pinimg.com/did-it/750x/90/89/45/908945db5f25216e64c0b466b214162b.jpg",
            collection_books: [],            
            collection_tutorials: [],
            collection_tags: [],
            images: []            
        },        
        %Collection{
            name: "anime",
            display_name: "Anime",
            external_url: "",            
            featured_image: "https://s-media-cache-ak0.pinimg.com/did-it/750x/90/89/45/908945db5f25216e64c0b466b214162b.jpg",
            collection_books: [],            
            collection_tutorials: [],
            collection_tags: [],
            images: []            
        },
    ]
})



  

# collection = Ecto.Changeset.change(%Post{}, title: "Hello", body: "world")

# comment = Ecto.Changeset.change(%Comment{}, body: "Excellent!")

# post_with_comments = Ecto.Changeset.put_assoc(post, :comments, [comment])


# Repo.insert!(post_with_comments)



# post = Ecto.Changeset.change(%Post{}, title: "Hello", body: "world")
# comment = Ecto.Changeset.change(%Comment{}, body: "Excellent!")
# post_with_comments = Ecto.Changeset.put_assoc(post, :comments, [comment])
# Repo.insert!(post_with_comments)


# collection_with_


# user_with 
# user_with_collections = Ecto.Changeset.put_assoc(

# # USERS 

# user = Ecto.Changeset.change(%User{}, 
#                                 name: "julius-reade",
#                                 display_name: "Julius Reade",
#                                 email: "julius_dott@hotmail.com",
#                                 password: "hellothere",
#                                 tier: "admin")
                                

# # COLLECTIONS 

# collection_one = Ecto.Changeset.change(%Collection{},
#                                     name: "figure-drawing",
#                                     display_name: "Figure Drawing",
#                                     external_url: "",
#                                     featured_image: "https://s-media-cache-ak0.pinimg.com/did-it/750x/90/89/45/908945db5f25216e64c0b466b214162b.jpg")

                                    

# # COLLECTION BOOKS 

# collection_one_book_one = Ecto.Changeset.change(%Book{},
#                                                 name: "this-is-the-book-name",
#                                                 display_name: "This is the Book Name",
#                                                 url: "http://phoenixframework.org/blog/seeding-data")

# collection_one_book_two = Ecto.Changeset.change(%Book{},
#                                                     name: "how-to-win-friends-and-all-that-jazz",
#                                                     display_name: "How to win books and all that Jazzzzz",
#                                                     url: "http://phoenixframework.org/blog/seeding-data")


# # COLLECTION TUTORIALS  
                                                    
# collection_one_tutorial_one = Ecto.Changeset.change(%Tutorial{},
#                                                         name: "this-is-the-tutorial-name",
#                                                         display_name: "This is the Tutorial Name",
#                                                         url: "http://phoenixframework.org/blog/seeding-data")

# collection_one_tutorial_two = Ecto.Changeset.change(%Tutorial{},
#                                                         name: "how-to-win-tutorials-and-all-that-jazz",
#                                                         display_name: "How to win tutorials and all that Jazzzzz",
#                                                         url: "http://phoenixframework.org/blog/seeding-data")
          
                                                        
# #IMAGES                                                        

# image_one = Ecto.Changeset.change(%ApiResources.Image{},
#                                             name: "caity",
#                                             display_name: "Caitlin Face",
#                                             description: "a really good photo of something OR rather",
#                                             image_url: "https://s-media-cache-ak0.pinimg.com/did-it/750x/90/89/45/908945db5f25216e64c0b466b214162b.jpg")

# image_two = Ecto.Changeset.change(%ApiResources.Image{},
#                                             name: "happily-there-you-know",
#                                             display_name: "Yes, We Know That Youre Happily There",
#                                             description: "take a compliment bby",                    
#                                             image_url: "https://s-media-cache-ak0.pinimg.com/did-it/750x/90/89/45/908945db5f25216e64c0b466b214162b.jpg")
                                                                    

# #IMAGE COMMENTS 

# image_one_comment_one = Ecto.Changeset.change(%Image.Comment{},
#                                         text: "this is a really good picture, I really like how it handles itself")

# image_one_comment_two = Ecto.Changeset.change(%Image.Comment{},
#                                         text: "super awesome, yeah boy!")

# #IMAGE SCRIBBLES 


# image_one_scribble_one = Ecto.Changeset.change(%Scribble{},
#                                                 name: "you-know",
#                                                 display_name: "Not Really TBH",
#                                                 description: "This is a scribble of an image",
#                                                 data: "")

# image_one_scribble_two = Ecto.Changeset.change(%Scribble{},
#                                                 name: "yep-yolo",
#                                                 display_name: "I like the hands",
#                                                 description: "The hands and ears are hearing",                            
#                                                 data: "")

# image_one_scribble_three = Ecto.Changeset.change(%Scribble{},
#                                                 name: "how-to-win-tutorials-and-all-that-jazz",
#                                                 display_name: "How to win tutorials and all that Jazzzzz",
#                                                 description: "we all know that you're going to be sorry",                                                        
#                                                 data: "")                            


#IMAGE TAGS 
