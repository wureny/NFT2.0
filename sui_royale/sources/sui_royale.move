module sui_royale::sui_royale {
    use std::string::{String};
    use sui::coin;
    use sui::coin::Coin;
    use sui::object;
    use sui::transfer::{share_object};
    use sui::tx_context::sender;
    use sui::sui::SUI;

    public struct NFT2 has key,store{
        id: UID,
        name: String,
        image_url: String,
        royale_points: u64,
        creator: address,
        title_owner: address,
        owner: address
    }

    const PERMISSION_DENIED:u8=1;
    const BALANCE_INSUFFICIENT:u8=2;

    fun init(ctx: &mut TxContext) {
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
        share_object(nft2);
    }

    public entry fun transfer_with_royale(to: address, nft: &mut NFT2, mut payment:Coin<SUI>, ctx: &mut TxContext) {
        assert!(sender(ctx) == nft.owner,PERMISSION_DENIED);
        assert!(coin::value(&payment) >= nft.royale_points, BALANCE_INSUFFICIENT);

        let royalty = coin::split(&mut payment, nft.royale_points, ctx);
        transfer::public_transfer(royalty, nft.creator);

        transfer::public_transfer(payment, sender(ctx));

        nft.owner = to;
        nft.title_owner = to;
    }

    public entry fun transfer_without_royale(to: address, mut nft: &mut NFT2, ctx: &mut TxContext) {
        assert!(sender(ctx)==nft.owner,PERMISSION_DENIED);
        nft.owner=to;
    }

    public entry fun reclaim(nft: &mut NFT2,ctx: &mut TxContext) {
        assert!(nft.title_owner==sender(ctx),PERMISSION_DENIED);
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
        assert!(sender(ctx)==nft.creator,PERMISSION_DENIED);
        nft.royale_points=roy;
    }
}
