<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeFile="gallery.aspx.cs" Inherits="gallery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
 <style>

       .btn.btn-block, .btn-block, .btn-group-block>.btn {
    padding: 11px 23px;
    font-size: 18px;
    line-height: 25px;
    text-decoration: none;
    color:#fff;
}

.shuffle-image {
  border-radius: 50%;
}

.column__image-elem
{
    margin:10px;
}

body.vertical {
  flex-direction: column;
  transition: 0.15s ease-out;
}

.container-01 {
  position: relative;
  display: grid;
  grid-template-rows: repeat(6, 1fr);
  grid-template-columns: repeat(5, 1fr);
  gap: 10px;
  justify-content: center;
  /*width: 90vmin; */
  height: 90vmin;
}

body.vertical .container {
  margin-bottom: 1rem;
  transition: 0.15s ease-out;
}

.item__title {
  position: absolute;
  top: 50%;
  left: 50%;
  color: #fff;
  font-size: 1rem;
  pointer-events: none;
  transition: 0.2s ease-out;
  transform: translate(-50%, -50%);
}

.item1 {
  grid-row: 1 / span 2;
  grid-column: 1 / span 2;
}
.item2 {
  grid-row: 1 / span 3;
  grid-column: 3 / span 3;
}
.item3 {
  grid-row: 3 / span 2;
  grid-column: 1 / span 2;
}
.item4 {
  grid-row: 4 / span 1;
  grid-column: 3 / span 1;
}
.item5 {
  grid-row: 5 / span 2;
  grid-column: 1 / span 3;
}
.item6 {
  grid-row: 4 / span 3;
  grid-column: 4 / span 2;
}

.shuffle-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 172px;
  height: 50px;
  margin-left: 20px;
  padding: 1rem;
  border: 1px solid #fff;
  border-radius: 10px;
  background-color: transparent;
  color: #fff;
  outline: none;
  font-weight: 700;
  font-size: 0.8rem;
  text-transform: uppercase;
  cursor: pointer;
  transition: all 0.1s ease-out, font-size 0.05s ease-out;
}

.shuffle-btn:hover {
  background-color: #777;
}

.shuffle-btn:active {
  font-size: 0.75rem;
}

</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <main class="body-container-wrapper" style="width: 100%;">
        
        <div class="container my-5">
            <asp:Repeater ID="datalist1" runat="server" >
    <ItemTemplate>


            <div class="row mt-5" id="displayData"  >
<style>
.item__img<%# Eval("id") %> {
  object-fit: cover;
  width: 100%;
  height: 100%;
  opacity: 0.5;
  transition: 0.3s ease-out;


  
}


.item-01<%# Eval("id") %>:hover .item__img<%# Eval("id") %> {
  opacity: 1;
}

.item-01<%# Eval("id") %>:hover .item__title {
  text-shadow: 0 2px 5px #000;
  opacity: 1;
}

.item-01<%# Eval("id") %>.active .item__title {
  display: none;
}


.item-01<%# Eval("id") %> {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
  border-radius: 15px;
  background-color: #F5F5F0;
  box-shadow: 0 0 6px #111;
}

.item-01<%# Eval("id") %>.active {
  position: absolute;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  z-index: 2;
  grid-row: unset;
  grid-column: unset;
}

.item-01<%# Eval("id") %>.active .item__img<%# Eval("id") %> {
  opacity: 1;
  
}

    </style>
                <div class="col-lg-5 heading-0101">
                    <div class="heading-packplus">
                        <h1><%# Eval("event_name") %></h1>
                        <div class="column__content column__content--left">

                            <p class="list-box"><strong><em>Date:</em></strong> <%# Eval("event_date") %></p>
                            <p><strong>Location:</strong> <%# Eval("event_address") %></p>
                            <p><%# Eval("event_city") %></p>
                            <p>
                                <%# Server.HtmlDecode( Eval("event_content").ToString()) %>
                            </p>

                        </div>
                    </div>
                </div>
                <div class="col-lg-7 mt-3" runat="server">
                    <div class="container-01">
                        <div class="item-01<%# Eval("id") %> item1">
                            <img src="" alt="image1" class="item__img<%# Eval("id") %>" id="img_0" />
                            <h1 class="item__title"></h1>
                        </div>
                        <div class="item-01<%# Eval("id") %> item2">
                            <img src="" alt="image2" class="item__img<%# Eval("id") %>" id="img_1" />
                            <h1 class="item__title"></h1>
                        </div>
                        <div class="item-01<%# Eval("id") %> item3">
                            <img src="" alt="image3" class="item__img<%# Eval("id") %>" id="img_2" />
                            <h1 class="item__title"></h1>
                        </div>
                        <div class="item-01<%# Eval("id") %> item4">
                            <img src="" alt="image4" class="item__img<%# Eval("id") %>" id="img_3" />
                            <h1 class="item__title"></h1>
                        </div>
                        <div class="item-01<%# Eval("id") %> item5">
                            <img src="" alt="image5" class="item__img<%# Eval("id") %>" id="img_4" />
                            <h1 class="item__title"></h1>
                        </div>
                        <div class="item-01<%# Eval("id") %> item6">
                            <img src="" alt="image6" class="item__img<%# Eval("id") %>" id="img_5" />
                            <h1 class="item__title"></h1>
                        </div>
                    </div>

                   <%-- <button class="shuffle-btn<%# Eval("id") %>"></button>--%>

                </div>

        <script>
            const body<%# Eval("id") %> = document.querySelector("body");
            const shuffleBtn<%# Eval("id") %> = document.querySelector(".shuffle-btn<%# Eval("id") %>");
            const items<%# Eval("id") %> = document.querySelectorAll(".item-01<%# Eval("id") %>");
            const images<%# Eval("id") %> = document.querySelectorAll(".item__img<%# Eval("id") %>");

            const imageLinks<%# Eval("id") %> = [
                 "<%# Eval("imgpath") %>",
                "<%# Eval("img_1") %>",
                "<%# Eval("img_2") %>",
                "<%# Eval("img_3") %>",
                "<%# Eval("img_4") %>",
                "<%# Eval("img_5") %>",


            ];

            shuffleImages<%# Eval("id") %>();
            checkOrientation<%# Eval("id") %>();

            window.addEventListener("resize", () => {
                checkOrientation<%# Eval("id") %>();
            });

            function everyTime<%# Eval("id") %>() {
                shuffleImages<%# Eval("id") %>();
                //console.log('each 1 second...');
            }

            var myInterval = setInterval(everyTime<%# Eval("id") %>, 1500);
            //shuffleBtn.addEventListener("click", shuffleImages)

            // sleep time expects milliseconds
            function sleep<%# Eval("id") %>(time) {
                return new Promise((resolve) => setTimeout(resolve, time));
            }

            sleep<%# Eval("id") %>(5000).then(() => {
                items<%# Eval("id") %>.forEach((elem) => {
                    zoomImage(elem);
                });
            });

            function checkOrientation<%# Eval("id") %>() {
                if (window.innerWidth < window.innerHeight) {
                    body<%# Eval("id") %>.classList.add("vertical");
                } else {
                    body<%# Eval("id") %>.classList.remove("vertical");
                }
            }

            function zoomImage(el) {
                el.classList.toggle("active");
            }

            function shuffleArray<%# Eval("id") %>(arr) {

                for (let i = arr.length - 1; i > 0; i--) {
                    const j = Math.floor(Math.random() * (i + 1));
                    [arr[i], arr[j]] = [arr[j], arr[i]];
                    //alert([j]);
                }
            }

            function shuffleImages<%# Eval("id") %>() {
                shuffleArray<%# Eval("id") %>(imageLinks<%# Eval("id") %>);

                for (let i = 0; i < images<%# Eval("id") %>.length; i++) {
                    images<%# Eval("id") %>[i].src = imageLinks<%# Eval("id") %>[i];
                   // alert(imageLinks<%# Eval("id") %>[i]);
                }
            }
        </script>


            </div>

       
      
        </ItemTemplate>
</asp:Repeater>
             <div class="col-lg-2 mt-3" runat="server">

                 <asp:LinkButton ID="btnLoadMore"  runat="server" class="btn btn-success btn-block" OnClick="btnLoadMore_Click">Load More Data</asp:LinkButton> 
        </div>
         
        </div>


    </main>


</asp:Content>



