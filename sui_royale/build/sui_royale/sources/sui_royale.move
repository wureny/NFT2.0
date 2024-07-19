module sui_royale::sui_royale {
    use std::string::{Self,String};
    use sui::object;
    use sui::token::confirm_with_treasury_cap;
    use sui::transfer::{transfer, public_transfer};
    use sui::tx_context::sender;

    public struct NFT2 has key{
        id: UID,
        name: String,
        image_url: String,
        royale_points: u64,
        creator: address,
        title_owner: address,
        owner: address
    }

    fun init(ctx: &mut TxContext) {
       /* let nft2 = NFT2{
            id: object::new(ctx),
            name: string::utf8(b"mynft"),
            image_url: string::utf8(b""),
            royale_points: 0,
            creator: sender(ctx),
            title_owner: sender(ctx),
            owner: sender(ctx),
        };*/
      //  public_transfer(nft2,sender(ctx));
    }

    public entry fun mint(name_: String, imagrUrl: String,royale_points_: u64,ctx: &mut TxContext) {
        let nft2 = NFT2 {
            id: object::new(ctx),
            name: name_,
            image_url: imagrUrl,
            royale_points: royale_points_,
            creator: sender(ctx),
            title_owner: sender(ctx),
            owner: sender(ctx)
        };
        transfer(nft2,sender(ctx));
    }
}
