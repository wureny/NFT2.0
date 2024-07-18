module sui_royale::sui_royale {
    use std::string::{Self,String};
    public struct NFT2 has key{
        id: UID,
        name: String,
        image_url: String,
        royale_points: u64,
        creator: address,
        title_owner: address,
        owner: address
    }
}
