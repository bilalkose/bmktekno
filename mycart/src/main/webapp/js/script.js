function add_to_cart(pid,pname,price){
    let cart = localStorage.getItem("cart");
    if(cart==null){
        //no cart yet
        let products=[];
        let product={productId:pid, productName:pname, productQuantity:1, productPrice:price}
        products.push(product);
        localStorage.setItem("cart",JSON.stringify(products));
        console.log("ilk defa eklendi");
    }
    else{
        //cart is already present
        let pcart = JSON.parse(cart);
        let oldProduct = pcart.find((item) => item.productId == pid)
        if(oldProduct){
            //we have to increase the quantity
            oldProduct.productQuantity=oldProduct.productQuantity+1;
            pcart.map((item) => {
                if(item.productId==oldProduct.productId){
                    item.productQuantity=oldProduct.productQuantity;
                }
            })

            localStorage.setItem("cart",JSON.stringify(pcart));    
            console.log("product quantity is increased");
        }
        else{
            //we have add the product
            let product={productId:pid, productName:pname, productQuantity:1, productPrice:price}
            pcart.push(product);
            localStorage.setItem("cart",JSON.stringify(pcart));
            console.log("product is added");
        }
    }

    updateCart();
}

//update cart:
function updateCart(){
    let cartString = localStorage.getItem("cart");
    let cart = JSON.parse(cartString);
    if(cart==null || cart.lenght==0){
        console.log("cart is empty!");
        $(".cart-items").html(" ( 0 ) ");
        $(".cart-body").html("<h3>Cart does not have any items</h3>");
        $(".checkout-btn").addClass('disabled');
    }
    else{
        //there is some in cart to show
        console.log(cart);
        $(".cart-items").html(`( ${cart.length} )`);
        let table=`
            <table class='table'>
            <thead class='thread-light'>
                <tr>
                    <th>Urun Adi:</th>
                    <th>Fiyati:</th>
                    <th>Adet:</th>
                    <th>Toplam Fiyat:</th>
                    <th>????leminiz:</th>


                </tr>


            </thead>

        
        
        
        `;

        let totalPrice = 0;

        cart.map((item)=>{
            table+=`
                <tr>
                    <td> ${item.productName} </td>
                    <td> ${item.productPrice} </td>
                    <td> ${item.productQuantity} </td>
                    <td> ${item.productQuantity*item.productPrice} </td>
                    <td> <button onclick='urunSil( ${item.productId} )' class="btn btn-danger btn-sm">Kald??r</button> </td>
                </tr>


            
            `
            totalPrice+=item.productPrice*item.productQuantity;


        })

        table=table + `
        
        <tr><td colspan='5' class='text-right' font-weight-bold>Toplam Fiyat: ${totalPrice}</td></tr>
        </table>`
        $(".cart-body").html(table);
    }


}

//urun sil
function urunSil(pid){
    let cart = JSON.parse(localStorage.getItem('cart'));
    let newcart =  cart.filter((item)=>item.productId != pid);
    localStorage.setItem('cart',JSON.stringify(newcart));
    updateCart();

}


// updateCart();
 $(document).ready(function(){
     updateCart();
 })