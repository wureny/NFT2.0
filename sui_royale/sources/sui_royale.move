module sui_royale::sui_royale {
    use std::string::{String};
    use sui::object;
    use sui::transfer::{ public_transfer};
    use sui::tx_context::sender;

    public struct NFT2 has key,store{
        id: UID,
        name: String,
        image_url: String,
        royale_points: u64,
        creator: address,
        title_owner: address,
        owner: address
    }

    fun init(ctx: &mut TxContext) {
        //TODO 定义错误码

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
        public_transfer(nft2,sender(ctx));
    }

    /*public entry fun transfer_with_royale(to: address, nft: NFT2, ctx: &mut TxContext) {
        let b = coin::balance<SUI>(to);
    let bal = balance::value<SUI>(to);
   // assert!();

    }
    */

    public entry fun transfer_without_royale(to: address, mut nft: &mut NFT2, ctx: &mut TxContext) {
        nft.owner=to;
    }

    public entry fun reclaim(nft: &mut NFT2,ctx: &mut TxContext) {
        assert!(nft.title_owner==sender(ctx),1);
        let to =nft.title_owner;
        nft.owner=to;
    }

    public entry fun getRoyale(nft: &NFT2,ctx: &mut TxContext) : u64{
        return nft.royale_points
    }

    public entry fun getTitleOwner(nft: &NFT2,ctx: &mut TxContext):address {
        return nft.title_owner
    }

    public entry fun getCreator(nft: &NFT2,ctx: &mut TxContext):address{
        return nft.creator
    }

    public entry fun getOwner(nft: &NFT2,ctx: &mut TxContext): address{
        return nft.owner
    }

    public entry fun changeRoyale(nft: &mut NFT2,roy: u64, ctx: &mut TxContext) {
        assert!(sender(ctx)==nft.creator,1);
        nft.royale_points=roy;

    }
}
